import {Directive, Input} from "@angular/core";
import {Router} from "@angular/router";
import {UserService} from '../services/user.service';

@Directive({
  selector: '[protected]'
})

export class ProtectedDirective {
  constructor(private userService: UserService, private router: Router) {
    userService.loadUser().subscribe(user => {
      if (user) {
        if (user.game) {
          router.navigateByUrl('game');
        }
        else if (user.room) {
          router.navigateByUrl('room');
        }
        else {
          router.navigateByUrl('rooms');
        }
      } else {
        router.navigateByUrl('/login');
      }
    });
  }

  @Input() set
}
