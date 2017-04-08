import {Injector, Component, OnInit} from '@angular/core';
import {CanActivate, Router} from '@angular/router-deprecated';
import {UserService} from '../services/user.service';
import {checkCondition} from '../check-condition';

@Component({
  selector: 'login-form',
  template: `
    Input your name:
    <form (ngSubmit)="login(name.value)">
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
