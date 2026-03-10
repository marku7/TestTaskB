<script setup>
import { Link, router } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
    task: Object,
});

function deleteTask() {
    if (confirm(`Are you sure you want to delete "${props.task.title}"?`)) {
        router.delete(`/tasks/${props.task.id}`);
    }
}

function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
}
</script>

<template>
    <AppLayout title="Task Details">
        <!-- Breadcrumb -->
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-6">
            <Link href="/tasks" class="hover:text-primary transition-colors">Tasks</Link>
            <span>/</span>
            <span class="text-secondary font-medium truncate">{{ task.title }}</span>
        </div>

        <div class="max-w-2xl">
            <div class="card p-6">
                <!-- Header -->
                <div class="flex items-start justify-between gap-4 mb-6">
                    <div class="flex-1 min-w-0">
                        <div class="mb-2">
                            <span :class="task.completed ? 'badge-completed' : 'badge-pending'">
                                {{ task.completed ? 'Completed' : 'Pending' }}
                            </span>
                        </div>
                        <h2 class="text-2xl font-bold text-secondary">{{ task.title }}</h2>
                    </div>
                    <div class="flex items-center gap-2 shrink-0">
                        <Link :href="`/tasks/${task.id}/edit`" class="btn-secondary">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                            Edit
                        </Link>
                        <button @click="deleteTask" class="btn-danger">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                            Delete
                        </button>
                    </div>
                </div>

                <!-- Description -->
                <div class="mb-6">
                    <h3 class="text-sm font-medium text-gray-500 mb-2">Description</h3>
                    <p v-if="task.description" class="text-secondary whitespace-pre-wrap">
                        {{ task.description }}
                    </p>
                    <p v-else class="text-sm text-gray-400 italic">No description provided.</p>
                </div>

                <!-- Meta -->
                <div class="pt-4 border-t border-gray-100 grid grid-cols-2 gap-4 text-sm">
                    <div>
                        <span class="text-gray-500">Created</span>
                        <p class="font-medium text-secondary mt-0.5">{{ formatDate(task.created_at) }}</p>
                    </div>
                    <div>
                        <span class="text-gray-500">Last updated</span>
                        <p class="font-medium text-secondary mt-0.5">{{ formatDate(task.updated_at) }}</p>
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <Link href="/tasks" class="text-sm text-gray-500 hover:text-primary transition-colors">
                    ← Back to tasks
                </Link>
            </div>
        </div>
    </AppLayout>
</template>
