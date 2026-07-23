import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { CourseService } from './course.service';
import { Course } from '../models/course.model';

describe('CourseService', () => {
  let service: CourseService;
  let httpMock: HttpTestingController;

  const mockCourses: Course[] = [
    { id: 1, name: 'Angular Basics', code: 'CS101', credits: 3, gradeStatus: 'passed' },
    { id: 2, name: 'TypeScript Advanced', code: 'CS102', credits: 4, gradeStatus: 'pending' }
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [CourseService]
    });

    service = TestBed.inject(CourseService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify(); // Asserts no outstanding unscheduled requests
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should fetch all courses successfully (GET)', () => {
    service.getCourses().subscribe((courses) => {
      expect(courses.length).toBe(2);
      expect(courses[0].name).toBe('Angular Basics');
    });

    const req = httpMock.expectOne('http://localhost:3000/courses');
    expect(req.request.method).toBe('GET');
    req.flush(mockCourses);
  });

  it('should catch error status 500 gracefully and throw custom message', () => {
    service.getCourses().subscribe({
      next: () => {
        expect('success callback').toBe('failure callback'); // acts as fail()
      },
      error: (err) => {
        expect(err.message).toContain('Failed to load courses. Please try again.');
      }
    });

    // Since CourseService has retry(2), there will be 1 initial request + 2 retries = 3 requests total to flush!
    for (let i = 0; i < 3; i++) {
      const req = httpMock.expectOne('http://localhost:3000/courses');
      req.flush('Error loading courses', { status: 500, statusText: 'Internal Server Error' });
    }
  });
});
