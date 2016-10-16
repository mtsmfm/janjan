import {Component} from '@angular/core';
import {UserService} from '../services/user.service';
import {User} from '../client';

@Component({
  selector: 'user-info',
  template: `
    <div *ngIf="currentUser">
      <p>{{currentUser.name}}</p>
    </div>
  `,
})
export class UserInfoComponent {
  constructor(private userService: UserService) {
    this.userService.user$.subscribe(user => this.currentUser = user);
  }
  private currentUser: User;
}
