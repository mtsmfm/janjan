import {Component, OnInit} from '@angular/core';
import {CanActivate, Router} from '@angular/router-deprecated';
import {RoomService} from '../services/room.service';
import {Room, Game} from '../client';
import {UserService} from '../services/user.service';
import {checkCondition} from '../check-condition';

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
@CanActivate(checkCondition)
export class RoomComponent implements OnInit {
  private room: Room;
  constructor(private roomService: RoomService, private router: Router) {
    this.roomService.room$.subscribe(
      room => {
        if (room.game) { this.router.navigate(['/Game']) }
        this.room = room;
      }
    );
  }
  start() {
    this.roomService.start().subscribe(
      () => this.router.navigate(['/Game'])
    );
  }
  ngOnInit() {
    this.roomService.loadRoom().subscribe(
      () => this.roomService.connectChannel().subscribe()
    );
  }
}
