import {Component} from '@angular/core';
import {CableService} from '../services/cable.service';

@Component({
  selector: 'my-app',
  template: `
    <user-info></user-info>
    <router-outlet></router-outlet>
  `,
  providers: [CableService]
})
export class AppComponent {
}
