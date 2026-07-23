import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course.service';
import { CreditLabelPipe } from '../../pipes/credit-label-pipe';

@Component({
  selector: 'app-course-detail',
  standalone: true,
  imports: [CommonModule, RouterLink, CreditLabelPipe],
  templateUrl: './course-detail.html',
  styleUrl: './course-detail.css'
})
export class CourseDetailComponent implements OnInit {
  course: Course | undefined;

  constructor(
    private route: ActivatedRoute,
    private courseService: CourseService
  ) {}

  ngOnInit(): void {
    // Subscribe to paramMap to retrieve route segments and query CourseService
    this.route.paramMap.subscribe(params => {
      const id = Number(params.get('id'));
      this.courseService.getCourseById(id).subscribe({
        next: (c) => this.course = c,
        error: (err) => {
          console.error('Failed to load course details:', err);
          this.course = undefined;
        }
      });
    });
  }
}
