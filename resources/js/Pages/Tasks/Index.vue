<script setup>
import { computed } from 'vue';
import { Link, router, usePage } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

defineProps({
    tasks: Object,
});

const flash = computed(() => usePage().props.flash);

function deleteTask(task) {
    if (confirm(`Are you sure you want to delete "${task.title}"?`)) {
        router.delete(`/tasks/${task.id}`);
    }
}
</script>

<template>
    <AppLayout title="Tasks">
        <!-- Flash Message -->
        <div
            v-if="flash.success"
            class="mb-6 p-4 bg-red-50 border border-red-100 rounded-lg flex items-center gap-3"
        >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary shrink-0" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
            </svg>
            <span class="text-sm font-medium text-primary">{{ flash.success }}</span>
        </div>

        <!-- Page Header -->
        <div class="flex items-center justify-between mb-6">
            <div>
                <h2 class="text-2xl font-bold text-secondary">All Tasks</h2>
                <p class="text-sm text-gray-500 mt-1">
                    {{ tasks.total }} task{{ tasks.total !== 1 ? 's' : '' }} total
                </p>
            </div>
        </div>

        <!-- Tasks Card -->
        <div class="card">
            <!-- Empty State -->
            <div v-if="tasks.data.length === 0" class="p-12 text-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto text-gray-300 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                </svg>
                <p class="text-gray-500 mb-4">No tasks yet.</p>
                <Link href="/tasks/create" class="btn-primary">Create your first task</Link>
            </div>

            <!-- Task Rows -->
            <div v-else>
                <div
                    v-for="task in tasks.data"
                    :key="task.id"
                    class="flex items-center justify-between px-5 py-4 border-b border-gray-100 last:border-b-0 hover:bg-gray-50 transition-colors"
                >
                    <div class="flex items-start gap-3 flex-1 min-w-0">
                        <span :class="task.completed ? 'badge-completed' : 'badge-pending'" class="mt-0.5 shrink-0">
                            {{ task.completed ? 'Completed' : 'Pending' }}
                        </span>
                        <div class="flex-1 min-w-0">
                            <Link
                                :href="`/tasks/${task.id}`"
                                class="font-medium text-secondary hover:text-primary transition-colors block truncate"
                            >
                                {{ task.title }}
                            </Link>
                            <p v-if="task.description" class="text-sm text-gray-500 mt-0.5 truncate">
                                {{ task.description }}
                            </p>
                        </div>
                    </div>
                    <div class="flex items-center gap-1 ml-4 shrink-0">
                        <Link :href="`/tasks/${task.id}/edit`" class="btn-icon-outline" title="Edit task">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                        </Link>
                        <button
                            @click="deleteTask(task)"
                            class="btn-icon-outline text-primary hover:text-red-700 hover:bg-red-50"
                            title="Delete task"
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div v-if="tasks.last_page > 1" class="mt-6 flex justify-center items-center gap-1">
            <component
                v-for="link in tasks.links"
                :key="link.label"
                :is="link.url ? 'a' : 'span'"
                :href="link.url"
                v-html="link.label"
                :class="[
                    'px-3 py-1.5 rounded text-sm font-medium transition-colors',
                    link.active
                        ? 'bg-primary text-white'
                        : link.url
                        ? 'text-gray-600 hover:bg-gray-100 cursor-pointer'
                        : 'text-gray-300 cursor-default',
                ]"
                @click.prevent="link.url && router.visit(link.url, { preserveScroll: true })"
            />
        </div>
    </AppLayout>
</template>
