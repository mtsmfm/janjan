import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Injectable} from '@angular/core';
import {CableService} from './cable.service';
import {DefaultApi, Game, Tile} from '../client';

@Injectable()
export class GameService {
  public game$: BehaviorSubject<Game>;
  private dataStore: {
    game: Game
  };
  constructor (private cableService: CableService, private api: DefaultApi) {
    this.dataStore = {game: null}
    this.game$ = new BehaviorSubject(this.dataStore.game);
  }
  get game() {
    return this.dataStore.game;
  }
  loadGame() {
    return this.api.gameGet().
      do(data => this.dataStore.game = data).
      do(() => this.game$.next(this.dataStore.game)).publish().refCount();
  }
  connectChannel() {
    this.cableService.connect();
    return this.cableService.channel$.do(
      data => {
        switch(data.event) {
          case 'game:update':
            this.dataStore.game = data.game;
            break;
        }
      }
    ).
      do(() => this.game$.next(this.dataStore.game)).publish().refCount();
  }
  discardTile(tile: Tile) {
    return this.api.gameActionsDiscardPost(tile.id);
  }
  drawTile() {
    return this.api.gameActionsDrawPost();
  }
  selfPick() {
    return this.api.gameActionsSelfPickPost()
  }
  confirm() {
    let key = Object.keys(this.game.links).find(e => this.game.links[e].meta);

    if (this.game.links.confirm_round_end) {
      return this.api.gameActionsConfirmRoundEndPost();
    } else {
      return this.api.gameActionsConfirmGameEndPost();
    }
  }
}
