import {Subject} from 'rxjs/Subject';
import {Injectable, NgZone} from 'angular2/core';

declare var ActionCable;

@Injectable()
export class CableService {
  public channel$;
  private cable;
  constructor (private _ngZone: NgZone) {
    this.channel$ = new Subject();
  }
  connect() {
    if (!this.cable) {
      let protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
      this.cable = ActionCable.createConsumer(`${protocol}//${window.location.host}/cable`);

      this.cable.subscriptions.create('WebNotificationsChannel', {
        received: (data) => {
          console.log(data);
          this._ngZone.run(() => this.channel$.next(data));
        }
      });
    }
  }
}
