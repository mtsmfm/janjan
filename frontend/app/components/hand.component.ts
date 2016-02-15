import {Component} from 'angular2/core';
import {GameService} from '../services/game.service';
import {Action, Tile, Hand} from '../interfaces/game';

@Component({
  selector: 'hand',
  inputs: ['hand', 'availableActions', 'relativePosition'],
  template: `
    <ul class="hand" [attr.data-discardable]="able(_Action.Discard)">
      <li *ngFor="#tile of hand.tiles" class="tile" [attr.data-tile]="tile.kind" [attr.data-discardable]="able(_Action.Discard)" (click)="discard(tile)">
      </li>
      <li *ngIf="able(_Action.Draw) && relativePosition === 'self'">
        <button (click)="draw()">Draw</button>
      </li>
      <li *ngIf="able(_Action.SelfPick) && relativePosition === 'self'">
        <button (click)="selfPick()">SelfPick</button>
      </li>
    </ul>
  `
})

export class HandComponent {
  public hand: Hand;
  public availableActions: Action[];
  public relativePosition: string;
  public _Action = Action;
  constructor(private _gameService: GameService) { }
  discard(tile: Tile) {
    if (!this.able(Action.Discard)) { return }

    this._gameService.discardTile(tile);
  }
  draw() {
    this._gameService.drawTile();
  }
  selfPick() {
    this._gameService.selfPick();
  }
  able(action: Action) {
    if (this.relativePosition != 'self') { return false }
    return this.availableActions.indexOf(action) >= 0;
  }
}
