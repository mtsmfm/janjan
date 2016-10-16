import {Component} from '@angular/core';
import {GameService} from '../services/game.service';
import {Tile, Hand} from '../client';

@Component({
  selector: 'hand',
  inputs: ['hand', 'links', 'relativePosition'],
  template: `
    <ul *ngIf="relativePosition === 'self'" class="hand tiles" [attr.data-discardable]="links.discard">
      <li *ngFor="let tile of sortedTiles" class="tile" [attr.data-tile]="tile.kind" [attr.data-discardable]="links.discard" (click)="discard(tile)">
      </li>
      <li *ngIf="links.draw">
        <button (click)="draw()">Draw</button>
      </li>
      <li *ngIf="links.self_pick">
        <button (click)="selfPick()">SelfPick</button>
      </li>
    </ul>
    <ul *ngIf="relativePosition !== 'self'" class="hand tiles">
      <li *ngFor="let tile of hand.tiles" class="tile" [attr.data-tile]="tile.kind">
      </li>
    </ul>
  `
})

export class HandComponent {
  public hand: Hand;
  public links: any;
  public relativePosition: string;
  constructor(private _gameService: GameService) { }
  discard(tile: Tile) {
    if (!this.links.discard) { return }
    this._gameService.discardTile(tile).subscribe();
  }
  draw() {
    this._gameService.drawTile().subscribe();
  }
  selfPick() {
    this._gameService.selfPick().subscribe();
  }
  get sortedTiles() {
    return this.hand.tiles.sort((a, b) => a.order - b.order);
  }
}
