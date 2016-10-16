import {Injector, Component, OnInit} from '@angular/core';
import {CanActivate, Router} from '@angular/router-deprecated';
import {RoomsService} from '../services/rooms.service';
import {UserService} from '../services/user.service';
import {Room} from '../client';
import {checkCondition} from '../check-condition';

@CanActivate(checkCondition)
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
      () => this.router.navigate(['/Room'])
    );
  }
  join(room: Room) {
    this.roomsService.join(room).subscribe(
      () => this.router.navigate(['/Room'])
    );
  }
  ngOnInit() {
    this.roomsService.loadRooms().subscribe();
    this.roomsService.connectChannel().subscribe();
  }
}
