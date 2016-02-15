import {Component} from 'angular2/core';
import {OnInit} from 'angular2/core';
import {GameService} from '../services/game.service';
import {UserService} from '../services/user.service';
import {GameBoardComponent} from './game-board.component';
import {User, Game} from '../interfaces/game';

@Component({
  selector: 'my-app',
  directives: [GameBoardComponent],
  providers: [GameService, UserService],
  template: `
    <game-board [game]="game" [currentUser]="currentUser"></game-board>
  `
})

export class GameComponent implements OnInit {
  public game: Game;
  public currentUser: User;
  constructor(private _gameService: GameService, private _userService: UserService) { }
  getGame() {
    this._gameService.game$.subscribe(
      updatedGame => {
        this.game = updatedGame;
      }
    );
    this._gameService.loadGame();
    this._gameService.subscribeChannel();
  }
  getCurrentUser() {
    this._userService.getUser().subscribe(user => this.currentUser = user);
  }
  ngOnInit() {
    this.getGame();
    this.getCurrentUser();
  }
}
