import {Injector} from 'angular2/core';
import {Router} from 'angular2/router';
import {appInjector} from './app-injector';
import {UserService} from './services/user.service';

export const checkCondition = (next, prev) => {
  let injector: Injector = appInjector();
	let router: Router = injector.get(Router);
	let userService: UserService = injector.get(UserService);

  return new Promise((resolve) => {
    userService.loadUser().subscribe(user => {
      if (user) {
        if (user.game) {
          if (next.urlPath === 'game') {
            resolve(true);
          } else {
            router.navigate(['/Game']);
            resolve(false);
          }
        }
        else if (user.room) {
          if (next.urlPath === 'room') {
            resolve(true);
          } else {
            router.navigate(['/Room']);
            resolve(false);
          }
        }
        else {
          if (next.urlPath === 'rooms') {
            resolve(true);
          } else {
            router.navigate(['/Rooms']);
            resolve(false);
          }
        }
      } else {
        if (next.urlPath === 'login') {
          resolve(true);
        } else {
          router.navigate(['/Login']);
          resolve(false);
        }
      }
    })
  })
}
