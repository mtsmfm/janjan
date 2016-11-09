import {Component, OnInit} from '@angular/core';
import {GameService} from '../services/game.service';
import {UserService} from '../services/user.service';
import {User, Game} from '../interfaces/game';

@Component({
  selector: 'game',
  providers: [GameService],
  template: `
    <game-board [game]="game" [currentUser]="currentUser"></game-board>
  `
})

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
