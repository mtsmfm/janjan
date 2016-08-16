import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import {Room} from '../interfaces/game';
import {CableService} from '../services/cable.service';

const endpoint = '/api/rooms';

@Injectable()
export class RoomsService {
  public rooms$: BehaviorSubject<Room[]>;
  private dataStore;
  constructor (private http: Http, private cableService: CableService) {
    this.dataStore = {rooms: []}
    this.rooms$ = new BehaviorSubject(this.dataStore.rooms);
  }
  createRoom() {
    return this.http.post(endpoint, {body: ''}).publish().refCount();
  }
  loadRooms() {
    return this.http.get(endpoint, {body: ''}).
      map(res => <Room[]> res.json().rooms).
      do(data => this.dataStore.rooms = data).
      do(() => this.rooms$.next(this.dataStore.rooms)).publish().refCount();
  }
  join(room: Room) {
    return this.http.post(room.links.join.url, {body: ''}).publish().refCount();
  }
  connectChannel() {
    this.cableService.connect();
    return this.cableService.channel$.do(
      data => {
        switch(data.event) {
          case 'room:create':
            this.dataStore.rooms.push(data.room);
            break;
          case 'room:destroy':
            this.dataStore.rooms = this.dataStore.rooms.filter(e => e.id !== data.room.id);
            break;
          case 'room:update':
            var index = this.dataStore.rooms.findIndex(e => e.id === data.room.id);
            if (index >= 0) {
              this.dataStore.rooms[index] = data.room;
            } else {
              this.dataStore.rooms.push(data.room);
            }
            break;
        }
      }
    ).
      do(() => this.rooms$.next(this.dataStore.rooms)).publish().refCount();
  }
}
