import {Subject} from 'rxjs/Subject';
import {Injectable} from '@angular/core';
import {CableService} from '../services/cable.service';
import {DefaultApi, Room} from '../client';

@Injectable()
export class RoomService {
  public room$: Subject<Room>;
  private dataStore: any;
  constructor (private cableService: CableService, private api: DefaultApi) {
    this.dataStore = {room: null};
    this.room$ = <Subject<Room>> new Subject();
  }
  start() {
    return this.api.gamePost().publish().refCount();
  }
  loadRoom() {
    return this.api.roomGet().
      do(data => this.dataStore.room = data).
      do(() => this.room$.next(this.dataStore.room)).publish().refCount();
  }
  connectChannel() {
    this.cableService.connect();
    return this.cableService.channel$.do(
      data => {
        switch(data.event) {
          case 'room:update':
            this.dataStore.room = data.room;
            break;
        }
      }
    ).
      do(() => this.room$.next(this.dataStore.room)).publish().refCount();
  }
}
