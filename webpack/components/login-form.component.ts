import {Injector, Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {UserService} from '../services/user.service';

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
export class LoginFormComponent {
  constructor(private userService: UserService, private router: Router) {}
  login(name: string) {
    this.userService.createUser(name).subscribe(() => this.router.navigateByUrl('rooms'));
  }
}
