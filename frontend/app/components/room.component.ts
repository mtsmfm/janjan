import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {RoomService} from '../services/room.service';
import {Room, Game} from '../interfaces/game';
import {UserService} from '../services/user.service';

@Component({
  selector: 'room',
  providers: [RoomService],
  template: `
    <div *ngIf="room">
      <h1>Room {{room.id}}</h1>
      <ul>
        <li *ngFor="let user of room.users">
          {{user.name}}
        <li>
      </ul>
      <button *ngIf="room.links.start" (click)="start()">Start</button>
    </div>
    `
})
export class RoomComponent implements OnInit {
  private room: Room;
  constructor(private roomService: RoomService, private router: Router) {
    this.roomService.room$.subscribe(
      room => {
        if (room.game) { this.router.navigateByUrl('/game') }
        this.room = room;
      }
    );
  }
  start() {
    this.roomService.start().subscribe(
      () => this.router.navigateByUrl('/game')
    );
  }
  ngOnInit() {
    this.roomService.loadRoom().subscribe(
      () => this.roomService.connectChannel().subscribe()
    );
  }
}
