import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { SimpleChange } from '@angular/core';
import { vi } from 'vitest';
import { CourseCardComponent } from './course-card';
import { Course } from '../../models/course.model';
import { provideHttpClient } from '@angular/common/http';

describe('CourseCardComponent', () => {
  let component: CourseCardComponent;
  let fixture: ComponentFixture<CourseCardComponent>;

  const mockCourse: Course = {
    id: 1,
    name: 'Data Structures',
    code: 'CS101',
    credits: 4,
    gradeStatus: 'passed'
  };

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CourseCardComponent],
      providers: [provideHttpClient()]
    }).compileComponents();

    fixture = TestBed.createComponent(CourseCardComponent);
    component = fixture.componentInstance;
    component.course = mockCourse;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render @Input course properties in template', () => {
    const titleEl = fixture.debugElement.query(By.css('.card-header h3')).nativeElement;
    const codeEl = fixture.debugElement.query(By.css('.course-code')).nativeElement;
    const creditsEl = fixture.debugElement.query(By.css('.credits-value')).nativeElement;

    expect(titleEl.textContent).toContain('Data Structures');
    expect(codeEl.textContent).toContain('CS101');
    expect(creditsEl.textContent).toContain('4 Credits'); // via CreditLabelPipe
  });

  it('should emit course ID on click to Enroll/Unenroll button', () => {
    vi.spyOn(component.enrollRequested, 'emit');
    
    const enrollBtn = fixture.debugElement.query(By.css('.btn-enroll')).nativeElement;
    enrollBtn.click();
    fixture.detectChanges();

    expect(component.enrollRequested.emit).toHaveBeenCalledWith(1);
  });

  it('should log previous and current course values in ngOnChanges', () => {
    vi.spyOn(console, 'log');

    const prevCourse: Course = { id: 0, name: 'Old', code: 'OLD', credits: 0, gradeStatus: 'pending' };
    const nextCourse: Course = { id: 2, name: 'New', code: 'NEW', credits: 3, gradeStatus: 'passed' };

    component.course = nextCourse;
    component.ngOnChanges({
      course: new SimpleChange(prevCourse, nextCourse, false)
    });

    expect(console.log).toHaveBeenCalledWith(
      'CourseCardComponent OnChanges: previousId = 0, currentId = 2'
    );
  });
});
