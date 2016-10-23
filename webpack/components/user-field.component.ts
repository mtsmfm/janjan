import {Component} from '@angular/core';
import {HandComponent} from './hand.component';
import {RiverComponent} from './river.component';
import {Direction, Seat} from '../interfaces/game';

@Component({
  selector: 'user-field',
  directives: [HandComponent, RiverComponent],
  inputs: ['seat', 'position', 'links'],
  template: `
    <div class="user-field" attr.data-relative-position="{{getRelativePosition()}}">
      <div class="center-area">
        <div class="player-info" attr.data-position="{{seat.position}}">
          <div class="player-info__point">{{seat.point}}</div>
          <div class="player-info__name">{{seat.user.name}}</div>
        </div>
        <river [river]="seat.river"></river>
      </div>
      <hand [hand]="seat.hand" [links]="links" [relativePosition]="getRelativePosition()"></hand>
    </div>
    `
})

export class UserFieldComponent {
  public seat: Seat;
  public position: Direction;
  public links: any;
  getRelativePosition() {
    if (this.seat.position == this.position) {
      return 'self';
    }
    else if (this.seat.position == this.nextPosition(this.position)) {
      return 'next';
    }
    else if (this.seat.position == this.previousPosition(this.position)) {
      return 'previous';
    }
    else {
      return 'opposite';
    }
  }
  nextPosition(position: Direction) {
    switch(position) {
      case Direction.East:
        return Direction.South;
      case Direction.South:
        return Direction.West;
      case Direction.West:
        return Direction.North;
      case Direction.North:
        return Direction.East;
    }
  }
  previousPosition(position: Direction) {
    switch(position) {
      case Direction.East:
        return Direction.North;
      case Direction.South:
        return Direction.East;
      case Direction.West:
        return Direction.South;
      case Direction.North:
        return Direction.West;
    }
  }
}
