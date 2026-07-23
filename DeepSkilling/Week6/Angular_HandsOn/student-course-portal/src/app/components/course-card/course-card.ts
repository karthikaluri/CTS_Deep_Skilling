import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Course } from '../../models/course.model';
import { EnrollmentService } from '../../services/enrollment.service';
import { HighlightDirective } from '../../directives/highlight';
import { CreditLabelPipe } from '../../pipes/credit-label-pipe';

@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [CommonModule, HighlightDirective, CreditLabelPipe],
  template: `
    <div class="course-card" [ngClass]="cardClasses" [ngStyle]="{ 'border-left': '6px solid ' + (course.gradeStatus === 'passed' ? '#4caf50' : course.gradeStatus === 'failed' ? '#f44336' : '#9e9e9e') }" [appHighlight]="'#2d2d2d'">
      <div class="card-header">
        <h3>{{ course.name }}</h3>
        <span class="course-code">{{ course.code }}</span>
      </div>

      <div class="card-body">
        <p>Credits: <span class="credits-value">{{ course.credits | creditLabel }}</span></p>
        
        <div class="grade-status" [ngSwitch]="course.gradeStatus">
          <span *ngSwitchCase="'passed'" class="badge badge-passed">Passed</span>
          <span *ngSwitchCase="'failed'" class="badge badge-failed">Failed</span>
          <span *ngSwitchCase="'pending'" class="badge badge-pending">Pending</span>
          <span *ngSwitchDefault class="badge badge-unknown">Unknown</span>
        </div>

        <div *ngIf="isExpanded" class="expanded-details">
          <p class="details-text">Course details: This syllabus covers critical foundational concepts of {{ course.name }} ({{ course.code }}) designed for modern engineering architectures.</p>
        </div>
      </div>

      <div class="card-actions">
        <button class="btn btn-secondary" (click)="toggleExpand()">
          {{ isExpanded ? 'Hide Details' : 'Show Details' }}
        </button>
        <button class="btn btn-enroll" [ngClass]="{ 'btn-unenroll': enrollmentService.isEnrolled(course.id) }" (click)="onEnrollToggle()">
          {{ enrollmentService.isEnrolled(course.id) ? 'Unenroll' : 'Enroll' }}
        </button>
      </div>
    </div>
  `,
  styles: []
})
export class CourseCardComponent implements OnChanges {
  @Input() course!: Course;
  @Output() enrollRequested = new EventEmitter<number>();

  isExpanded = false;
  enrollmentService = inject(EnrollmentService);

  constructor() {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['course']) {
      const prev = changes['course'].previousValue;
      const curr = changes['course'].currentValue;
      console.log(`CourseCardComponent OnChanges: previousId = ${prev ? prev.id : 'null'}, currentId = ${curr ? curr.id : 'null'}`);
    }
  }

  toggleExpand(): void {
    this.isExpanded = !this.isExpanded;
  }

  onEnrollToggle(): void {
    if (this.enrollmentService.isEnrolled(this.course.id)) {
      this.enrollmentService.unenroll(this.course.id);
    } else {
      this.enrollmentService.enroll(this.course.id);
    }
    this.enrollRequested.emit(this.course.id);
  }

  get cardClasses() {
    return {
      'card--enrolled': this.enrollmentService.isEnrolled(this.course.id),
      'card--full': this.course.credits >= 4,
      'expanded': this.isExpanded
    };
  }
}
