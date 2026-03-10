@extends('layout')

@section('title', $task->title)

@section('content')
<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Task Detail</h5>
                @if($task->completed)
                    <span class="badge bg-success">Completed</span>
                @else
                    <span class="badge bg-warning text-dark">Pending</span>
                @endif
            </div>
            <div class="card-body">
                <h4 class="{{ $task->completed ? 'task-done' : '' }}">{{ $task->title }}</h4>
                @if($task->description)
                    <p class="text-muted">{{ $task->description }}</p>
                @else
                    <p class="text-muted fst-italic">No description provided.</p>
                @endif
                <small class="text-muted">Created: {{ $task->created_at->diffForHumans() }}</small>
            </div>
            <div class="card-footer d-flex gap-2">
                <a href="{{ route('tasks.edit', $task) }}" class="btn btn-primary">Edit</a>
                <form action="{{ route('tasks.destroy', $task) }}" method="POST"
                      onsubmit="return confirm('Delete this task?')">
                    @csrf
                    @method('DELETE')
                    <button class="btn btn-danger">Delete</button>
                </form>
                <a href="{{ route('tasks.index') }}" class="btn btn-secondary ms-auto">Back to List</a>
            </div>
        </div>
    </div>
</div>
@endsection
