import {Observable} from 'rxjs/Observable';
import {Injectable, NgZone} from 'angular2/core';
import {Http, Headers} from 'angular2/http';
import {Game, Tile} from '../interfaces/game';

declare var App;

@Injectable()
export class GameService {
  public game$: Observable<Game>;
  private _gameObserver: any;
  private _dataStore: {
    game: Game
  };
  constructor (private http: Http, private _ngZone: NgZone) {
    this.game$ = new Observable(observer => this._gameObserver = observer).share();
    this._dataStore = { game: null }
  }
  loadGame() {
    this.request(this.http.get('/api/game'));
  }
  subscribeChannel() {
    App.cable.subscriptions.create('WebNotificationsChannel', {
      received: ()=> {
        this._ngZone.run(() => this.loadGame());
      }
    });
  }
  discardTile(tile: Tile) {
    this.request(this.http.post('/api/game/actions', JSON.stringify({type: 'discard', id: tile.id})))
  }
  drawTile() {
    this.request(this.http.post('/api/game/actions', JSON.stringify({type: 'draw'})))
  }
  selfPick() {
    this.request(this.http.post('/api/game/actions', JSON.stringify({type: 'self_pick'})))
  }
  request(observable) {
    observable.map(res => <Game> res.json()).subscribe(data => {
      this._dataStore.game = data;
      this._gameObserver.next(this._dataStore.game);
    })
  }
}
