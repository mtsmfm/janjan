import {Injector, Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {RoomsService} from '../services/rooms.service';
import {UserService} from '../services/user.service';
import {Room} from '../interfaces/game';

@Component({
  selector: 'room-list',
  providers: [RoomsService],
  template: `
    <h1>Rooms</h1>
    <button (click)="createRoom()">Create Room</button>
    <ul>
      <li *ngFor="let room of rooms" class="room">
        <div class="room__id">
          {{room.id}}
        </div>
        <div class="room__users-count">
          {{room.users.length}} / 4
        </div>
        <button class="room__join-button" (click)="join(room)">Join</button>
      <li>
    </ul>
    `
})
export class RoomListComponent implements OnInit {
  private rooms: Room[];
  constructor(private roomsService: RoomsService, private router: Router) {
    this.roomsService.rooms$.
      map(rooms => rooms.filter(r => r.links.hasOwnProperty('join'))).
      subscribe(rooms => this.rooms = rooms);
  }
  createRoom() {
    this.roomsService.createRoom().subscribe(
      () => this.router.navigateByUrl('room')
    );
  }
  join(room: Room) {
    this.roomsService.join(room).subscribe(
      () => this.router.navigateByUrl('room')
    );
  }
  ngOnInit() {
    this.roomsService.loadRooms().subscribe();
    this.roomsService.connectChannel().subscribe();
  }
}
