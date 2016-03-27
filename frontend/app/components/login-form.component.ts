import {Injector, Component, OnInit} from 'angular2/core';
import {CanActivate, Router} from 'angular2/router';
import {UserService} from '../services/user.service';
import {checkCondition} from '../check-condition';

@Component({
  selector: 'login-form',
  template: `
    Input your name:
    <form (submit)="login(name.value)">
      <input #name>
      <button type="submit">Login</button>
    </form>
    `
})
@CanActivate(checkCondition)
export class LoginFormComponent {
  constructor(private userService: UserService, private router: Router) { }
  login(name: string) {
    this.userService.createUser(name).subscribe(() => this.router.navigate(['/Rooms']));
  }
}
