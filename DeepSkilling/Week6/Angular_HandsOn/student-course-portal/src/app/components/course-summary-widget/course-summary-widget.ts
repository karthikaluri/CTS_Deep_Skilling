import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Observable } from 'rxjs';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';

@Component({
  selector: 'app-course-summary-widget',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './course-summary-widget.html',
  styleUrl: './course-summary-widget.css'
})
export class CourseSummaryWidgetComponent implements OnInit {
  courses$!: Observable<Course[]>;

  constructor(public courseService: CourseService) {}

  ngOnInit(): void {
    this.courses$ = this.courseService.getCourses();
  }

  addSampleCourse(): void {
    const newId = Math.floor(Math.random() * 1000) + 10;
    const sample: Omit<Course, 'id'> = {
      name: `Sample Course ${newId}`,
      code: `CS${newId}`,
      credits: 3,
      gradeStatus: 'pending'
    };
    
    this.courseService.createCourse(sample).subscribe({
      next: () => {
        // Refresh local list
        this.courses$ = this.courseService.getCourses();
      },
      error: (err) => console.error('Failed to create sample course:', err)
    });
  }
}
