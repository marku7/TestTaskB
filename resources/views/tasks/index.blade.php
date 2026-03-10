@extends('layout')

@section('title', 'All Tasks')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Tasks</h2>
    <a href="{{ route('tasks.create') }}" class="btn btn-primary">+ New Task</a>
</div>

@if($tasks->isEmpty())
@else
    <div class="list-group">
        @foreach($tasks as $task)
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                    <span class="{{ $task->completed ? 'task-done' : '' }}">
                        {{ $task->title }}
                    </span>
                    @if($task->completed)
                        <span class="badge bg-success ms-2">Done</span>
                    @else
                        <span class="badge bg-warning text-dark ms-2">Pending</span>
                    @endif
                    @if($task->description)
                        <p class="mb-0 text-muted small">{{ $task->description }}</p>
                    @endif
                </div>
                <div class="d-flex gap-2">
                    <a href="{{ route('tasks.show', $task) }}" class="btn btn-sm btn-outline-secondary">View</a>
                    <a href="{{ route('tasks.edit', $task) }}" class="btn btn-sm btn-outline-primary">Edit</a>
                    <form action="{{ route('tasks.destroy', $task) }}" method="POST"
                          onsubmit="return confirm('Delete this task?')">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-sm btn-outline-danger">Delete</button>
                    </form>
                </div>
            </div>
        @endforeach
    </div>
    <div class="mt-3">{{ $tasks->links() }}</div>
@endif
@endsection
