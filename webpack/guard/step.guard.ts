import { Injectable } from '@angular/core';
import { UserService } from '../services/user.service';
import { ActivatedRouteSnapshot, Router, CanActivate, RouterStateSnapshot } from '@angular/router';


@Injectable()
export class StepGuard implements CanActivate {
  constructor(private router: Router, private userService: UserService) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    return new Promise((resolve) => {
      this.userService.loadUser().subscribe(user => {
        if (user) {
          if (user.game) {
            if (state.url === '/game') {
              resolve(true);
            } else {
              this.router.navigate(['/game']);
              resolve(false);
            }
          }
          else if (user.room) {
            if (state.url === '/room') {
              resolve(true);
            } else {
              this.router.navigate(['/room']);
              resolve(false);
            }
          }
          else {
            if (state.url === '/rooms') {
              resolve(true);
            } else {
              this.router.navigate(['/rooms']);
              resolve(false);
            }
          }
        } else {
          if (state.url === '/login') {
            resolve(true);
          } else {
            this.router.navigate(['/login']);
            resolve(false);
          }
        }
      })
    })
  }
}
