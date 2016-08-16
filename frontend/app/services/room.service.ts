import {Subject} from 'rxjs/Subject';
import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import {Room} from '../interfaces/game';
import {CableService} from '../services/cable.service';

@Injectable()
export class RoomService {
  public room$: Subject<Room>;
  private dataStore: any;
  constructor (private http: Http, private cableService: CableService) {
    this.dataStore = {room: null};
    this.room$ = <Subject<Room>> new Subject();
  }
  start() {
    return this.http.post(this.dataStore.room.links.start.url, {body: ''}).publish().refCount();
  }
  loadRoom() {
    return this.http.get('/api/room', {body: ''}).
      map(res => <Room> res.json().room).
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
