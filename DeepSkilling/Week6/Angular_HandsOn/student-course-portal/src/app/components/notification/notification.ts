import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { NotificationService } from '../../services/notification';

@Component({
  selector: 'app-notification',
  standalone: true,
  imports: [CommonModule, FormsModule],
  providers: [NotificationService], // Component-level provider
  templateUrl: './notification.html',
  styleUrl: './notification.css'
})
export class NotificationComponent implements OnInit {
  @Input() widgetTitle = 'Notification Center';
  newMessage = '';
  
  // Comment: Providing NotificationService in the component-level providers list tells Angular's Dependency Injection system to instantiate a new instance of this service unique to this component instance (and its child elements). It bypasses the root/global singleton injector, meaning different instances of this component will each have their own isolated notification list state.

  constructor(public notificationService: NotificationService) {}

  ngOnInit(): void {
    this.notificationService.addNotification('System active - initialized locally.');
  }

  sendNotification(): void {
    if (this.newMessage.trim()) {
      this.notificationService.addNotification(this.newMessage.trim());
      this.newMessage = '';
    }
  }
}
