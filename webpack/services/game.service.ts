import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Injectable} from '@angular/core';
import {Http, Headers} from '@angular/http';
import {Game, Tile} from '../interfaces/game';
import {CableService} from './cable.service';

const endpoint = '/api/game';

@Injectable()
export class GameService {
  public game$: BehaviorSubject<Game>;
  private dataStore: {
    game: Game
  };
  constructor (private http: Http, private cableService: CableService) {
    this.dataStore = {game: null}
    this.game$ = new BehaviorSubject(this.dataStore.game);
  }
  get game() {
    return this.dataStore.game;
  }
  loadGame() {
    return this.http.get(endpoint, {body: ''}).
      map(res => <Game> res.json().game).
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
    return this.http.post(this.game.links.discard.url, JSON.stringify({id: tile.id}));
  }
  drawTile() {
    return this.http.post(this.game.links.draw.url, {body: ''});
  }
  selfPick() {
    return this.http.post(this.game.links.self_pick.url, {body: ''});
  }
  confirm() {
    let key = Object.keys(this.game.links).find(e => this.game.links[e].meta);

    return this.http.post(this.game.links[key].url, {body: ''});
  }
}
