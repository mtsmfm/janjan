import {Component} from '@angular/core';
import {UserFieldComponent} from './user-field.component';
import {GameInfoComponent} from './game-info.component';
import {GameDialogComponent} from './game-dialog.component';
import {User, Game} from '../client';

@Component({
  selector: 'game-board',
  directives: [UserFieldComponent, GameInfoComponent, GameDialogComponent],
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
