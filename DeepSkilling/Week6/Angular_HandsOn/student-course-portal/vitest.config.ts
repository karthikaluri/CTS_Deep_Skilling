import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./setup-vitest.ts'],
    include: [
      'src/app/components/course-card/course-card.spec.ts',
      'src/app/services/course.service.spec.ts',
      'src/app/pages/course-list/course-list.spec.ts'
    ]
  }
});
