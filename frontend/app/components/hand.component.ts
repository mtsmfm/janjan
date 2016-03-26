import {Component} from 'angular2/core';
import {GameService} from '../services/game.service';
import {Tile, Hand, Action} from '../interfaces/game';

@Component({
  selector: 'hand',
  inputs: ['hand', 'links', 'relativePosition'],
  template: `
    <ul *ngIf="relativePosition === 'self'" class="hand tiles" [attr.data-discardable]="able(_Action.Discard)">
      <li *ngFor="#tile of sortedTiles" class="tile" [attr.data-tile]="tile.kind" [attr.data-discardable]="able(_Action.Discard)" (click)="discard(tile)">
      </li>
      <li *ngIf="able(_Action.Draw)">
        <button (click)="draw()">Draw</button>
      </li>
      <li *ngIf="able(_Action.SelfPick)">
        <button (click)="selfPick()">SelfPick</button>
      </li>
    </ul>
    <ul *ngIf="relativePosition !== 'self'" class="hand tiles">
      <li *ngFor="#tile of hand.tiles" class="tile" [attr.data-tile]="tile.kind">
      </li>
    </ul>
  `
})

export class HandComponent {
  public hand: Hand;
  public links: any;
  public relativePosition: string;
  public _Action = Action;
  constructor(private _gameService: GameService) { }
  discard(tile: Tile) {
    if (!this.able(Action.Discard)) { return }
    this._gameService.discardTile(tile).subscribe();
  }
  draw() {
    this._gameService.drawTile().subscribe();
  }
  selfPick() {
    this._gameService.selfPick().subscribe();
  }
  able(action: Action) {
    return !!this.links[action];
  }
  get sortedTiles() {
    return this.hand.tiles.sort((a, b) => a.order - b.order);
  }
}
