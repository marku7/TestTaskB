<script setup>
import { useForm, Link } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
    task: Object,
});

const form = useForm({
    title: props.task.title,
    description: props.task.description ?? '',
    completed: props.task.completed,
});

function submit() {
    form.put(`/tasks/${props.task.id}`);
}
</script>

<template>
    <AppLayout title="Edit Task">
        <!-- Breadcrumb -->
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-6">
            <Link href="/tasks" class="hover:text-primary transition-colors">Tasks</Link>
            <span>/</span>
            <Link :href="`/tasks/${task.id}`" class="hover:text-primary transition-colors max-w-xs truncate">
                {{ task.title }}
            </Link>
            <span>/</span>
            <span class="text-secondary font-medium">Edit</span>
        </div>

        <div class="max-w-2xl">
            <h2 class="text-2xl font-bold text-secondary mb-6">Edit Task</h2>

            <div class="card p-6">
                <form @submit.prevent="submit" class="space-y-5">
                    <!-- Title -->
                    <div>
                        <label for="title" class="form-label">
                            Title <span class="text-primary">*</span>
                        </label>
                        <input
                            id="title"
                            v-model="form.title"
                            type="text"
                            class="form-input"
                            :class="{ 'is-invalid': form.errors.title }"
                            placeholder="Enter task title"
                            autofocus
                        />
                        <p v-if="form.errors.title" class="mt-1 text-sm text-primary">
                            {{ form.errors.title }}
                        </p>
                    </div>

                    <!-- Description -->
                    <div>
                        <label for="description" class="form-label">Description</label>
                        <textarea
                            id="description"
                            v-model="form.description"
                            class="form-input"
                            :class="{ 'is-invalid': form.errors.description }"
                            rows="4"
                            placeholder="Enter task description (optional)"
                        />
                        <p v-if="form.errors.description" class="mt-1 text-sm text-primary">
                            {{ form.errors.description }}
                        </p>
                    </div>

                    <!-- Completed -->
                    <div class="flex items-center gap-3">
                        <input
                            id="completed"
                            v-model="form.completed"
                            type="checkbox"
                            class="h-4 w-4 rounded border-gray-300 text-primary focus:ring-primary cursor-pointer accent-primary"
                        />
                        <label for="completed" class="form-label mb-0 cursor-pointer">
                            Mark as completed
                        </label>
                    </div>

                    <!-- Actions -->
                    <div class="flex items-center gap-3 pt-2">
                        <button type="submit" class="btn-primary" :disabled="form.processing">
                            {{ form.processing ? 'Saving...' : 'Save Changes' }}
                        </button>
                        <Link :href="`/tasks/${task.id}`" class="btn-secondary">Cancel</Link>
                    </div>
                </form>
            </div>
        </div>
    </AppLayout>
</template>
