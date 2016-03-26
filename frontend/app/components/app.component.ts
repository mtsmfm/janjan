import {Component} from 'angular2/core';
import {Router, RouteConfig, ROUTER_DIRECTIVES} from 'angular2/router';
import {RoomListComponent} from './room-list.component';
import {RoomComponent} from './room.component';
import {LoginFormComponent} from './login-form.component';
import {UserInfoComponent} from './user-info.component';
import {GameComponent} from './game.component';
import {UserService} from '../services/user.service';
import {CableService} from '../services/cable.service';

@Component({
  selector: 'my-app',
  template: `
    <user-info></user-info>
    <router-outlet></router-outlet>
  `,
  providers: [CableService],
  directives: [ROUTER_DIRECTIVES, UserInfoComponent]
})
@RouteConfig([
  {path:'/rooms', name: 'Rooms', component: RoomListComponent},
  {path:'/room',  name: 'Room',  component: RoomComponent},
  {path:'/game',  name: 'Game',  component: GameComponent},
  {path:'/login', name: 'Login', component: LoginFormComponent, useAsDefault: true}
])
export class AppComponent {
  constructor(private userService: UserService, private router: Router) { }
}
