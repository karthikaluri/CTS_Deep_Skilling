import { Injectable } from '@angular/core';

@Injectable() // Omit providedIn: 'root' so that it is scoped locally when defined in component providers
export class NotificationService {
  private notifications: string[] = [];

  constructor() {}

  addNotification(message: string): void {
    const timestamp = new Date().toLocaleTimeString();
    this.notifications.push(`[${timestamp}] ${message}`);
  }

  getNotifications(): string[] {
    return this.notifications;
  }

  clear(): void {
    this.notifications = [];
  }
}
