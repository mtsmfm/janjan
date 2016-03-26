import {Component} from 'angular2/core';
import {UserService} from '../services/user.service';
import {User} from '../interfaces/game';

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
