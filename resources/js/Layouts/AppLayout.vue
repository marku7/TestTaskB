<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    title: String,
});
</script>

<template>
    <div class="min-h-screen bg-gray-50">
        <!-- Header -->
        <header class="bg-white border-b border-gray-200 sticky top-0 z-10 shadow-sm">
            <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between h-16">
                    <Link href="/tasks" class="flex items-center gap-1.5 text-xl font-bold">
                        <span class="text-primary">Test</span><span class="text-secondary">Task</span>
                    </Link>
                    <Link href="/tasks/create" class="btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                        Add Task
                    </Link>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <main class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <slot />
        </main>
    </div>
</template>
