import {Component} from '@angular/core';
import {User, Game} from '../interfaces/game';

@Component({
  selector: 'game-board',
  inputs: ['game', 'currentUser'],
  template: `
    <div class="game-board" *ngIf="game && currentUser">
      <user-field *ngFor="let seat of game.seats" [seat]="seat" [position]="getCurrentPosition()" [links]="game.links"></user-field>
      <game-info [game]="game"></game-info>
      <game-dialog [link]="link"></game-dialog>
    </div>
    `
})

export class GameBoardComponent {
  public game: Game;
  public currentUser: User;
  getCurrentPosition() {
    return this.game.seats.find(seat => {return seat.user.id == this.currentUser.id}).position;
  }
  get link() {
    if (this.game && this.game.links) {
      let key = Object.keys(this.game.links).find(e => this.game.links[e].meta);
      return this.game.links[key];
    }
  }
}
