import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Observable } from 'rxjs';
import { Store } from '@ngrx/store';
import { Course } from '../../models/course.model';
import { CourseCardComponent } from '../../components/course-card/course-card';
import * as CourseActions from '../../store/course/course.actions';
import * as CourseSelectors from '../../store/course/course.selectors';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  template: `
    <div class="course-list-container">
      <h2>Available Courses</h2>
      <p class="description">Browse the list of available academic modules. Use details and enroll buttons to customize your enrollment status.</p>

      <div class="list-actions">
        <button class="btn btn-primary" (click)="resetList()">Refresh Course List</button>
      </div>

      <!-- Error Banner -->
      <div *ngIf="errorMessage$ | async as errorMessage" class="error-banner">
        <strong>Error:</strong> {{ errorMessage }}
      </div>

      <!-- Loading State Indicator -->
      <div *ngIf="isLoading$ | async; else listTemplate" class="loading-state">
        <div class="spinner"></div>
        <p>Loading available courses, please wait...</p>
      </div>

      <!-- Course list or empty list template -->
      <ng-template #listTemplate>
        <div *ngIf="courses$ | async as courses">
          <div *ngIf="courses.length > 0; else noCourses" class="course-grid">
            <app-course-card 
              *ngFor="let c of courses; trackBy: trackByCourseId" 
              [course]="c" 
              (enrollRequested)="onEnroll($event)">
            </app-course-card>
          </div>
        </div>
        
        <ng-template #noCourses>
          <div class="no-courses-card">
            <p>No courses available at this moment.</p>
          </div>
        </ng-template>
      </ng-template>

      <!-- Selection Confirmation -->
      <div *ngIf="selectedCourseId" class="selection-banner">
        <p>Selected course ID: <strong>{{ selectedCourseId }}</strong> (State updated dynamically via Parent-Child @Output)</p>
      </div>
    </div>
  `,
  styles: []
})
export class CourseListComponent implements OnInit {
  courses$!: Observable<Course[]>;
  isLoading$!: Observable<boolean>;
  errorMessage$!: Observable<string | null>;
  selectedCourseId: number | null = null;

  private store = inject(Store);

  constructor() {}

  ngOnInit(): void {
    this.store.dispatch(CourseActions.loadCourses());
    this.courses$ = this.store.select(CourseSelectors.selectAllCourses);
    this.isLoading$ = this.store.select(CourseSelectors.selectCoursesLoading);
    this.errorMessage$ = this.store.select(CourseSelectors.selectCoursesError);
  }

  trackByCourseId(index: number, course: Course): number {
    return course.id;
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course via selector: ' + courseId);
    this.selectedCourseId = courseId;
  }

  resetList(): void {
    this.store.dispatch(CourseActions.loadCourses());
  }
}
