import {Component} from '@angular/core';
import {Game} from '../client';

@Component({
  selector: 'game-info',
  inputs: ['game'],
  template: `
    <div class="game-info" *ngIf="game">
      <div class="game-info__item">
        {{game.wind}} {{game.round_number}}
      </div>
      <div class="gmae-info__item" *ngIf="game.bonus_count > 0">
        Bonus {{game.bonus_count}}
      </div>
    </div>
    `
})

export class GameInfoComponent {
  public game: Game;
}
