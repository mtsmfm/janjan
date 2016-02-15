import {Component} from 'angular2/core';
import {UserFieldComponent} from './user-field.component';
import {User, Game} from '../interfaces/game';

@Component({
  selector: 'game-board',
  directives: [UserFieldComponent],
  inputs: ['game', 'currentUser'],
  template: `
    <div class="game-board" *ngIf="game && currentUser">
      <user-field *ngFor="#seat of game.seats" [seat]="seat" [position]="getCurrentPosition()" [availableActions]="game.available_actions"></user-field>
    </div>
    `
})

export class GameBoardComponent {
  public game: Game;
  public currentUser: User;
  getCurrentPosition() {
    return this.game.seats.find(seat => {return seat.user.id == this.currentUser.id}).position;
  }
}
