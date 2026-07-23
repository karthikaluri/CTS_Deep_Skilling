import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home';
import { CoursesLayoutComponent } from './pages/courses-layout/courses-layout';
import { CourseListComponent } from './pages/course-list/course-list';
import { CourseDetailComponent } from './pages/course-detail/course-detail';
import { StudentProfileComponent } from './pages/student-profile/student-profile';
import { NotFoundComponent } from './pages/not-found/not-found';
import { authGuard } from './guards/auth.guard';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  {
    path: 'courses',
    component: CoursesLayoutComponent,
    children: [
      { path: '', component: CourseListComponent },
      { path: ':id', component: CourseDetailComponent }
    ]
  },
  {
    path: 'profile',
    component: StudentProfileComponent,
    canActivate: [authGuard]
  },
  {
    path: 'enroll',
    loadChildren: () => import('./features/enrollment/enrollment-module').then(m => m.EnrollmentModule)
  },
  { path: '**', component: NotFoundComponent }
];
