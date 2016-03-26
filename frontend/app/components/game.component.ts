import {Component, OnInit} from 'angular2/core';
import {CanActivate} from 'angular2/router';
import {GameService} from '../services/game.service';
import {UserService} from '../services/user.service';
import {GameBoardComponent} from './game-board.component';
import {User, Game} from '../interfaces/game';
import {checkCondition} from '../check-condition';

@Component({
  selector: 'game',
  directives: [GameBoardComponent],
  providers: [GameService],
  template: `
    <game-board [game]="game" [currentUser]="currentUser"></game-board>
  `
})

@CanActivate(checkCondition)
export class GameComponent implements OnInit {
  public game: Game;
  public currentUser: User;
  constructor(private gameService: GameService, private userService: UserService) {
    this.gameService.game$.subscribe(game => this.game = game);
    this.userService.user$.subscribe(user => this.currentUser = user);
  }
  ngOnInit() {
    this.gameService.loadGame().subscribe(
      () => this.gameService.connectChannel().subscribe()
    );
    this.userService.loadUser().subscribe();
  }
}
