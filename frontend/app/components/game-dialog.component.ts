import {Component} from 'angular2/core';
import {GameService} from '../services/game.service';
import {Game} from '../interfaces/game';
import {Router} from 'angular2/router';

@Component({
  selector: 'game-dialog',
  inputs: ['link'],
  template: `
    <div class="game-dialog" *ngIf="link">
      <p class="game-dialog__message">{{link.meta.message}}</p>
      <ul class="tiles">
        <li *ngFor="#tile of link.meta.tiles" class="tile" [attr.data-tile]="tile.kind">
        </li>
      </ul>
      <ul>
        <li *ngFor="#result of link.meta.results">
          {{result.user.name}} : {{result.point}}
        </li>
      </ul>
      <button (click)="ok()">OK</button>
    </div>
    `
})

export class GameDialogComponent {
  public link;
  constructor(private gameService: GameService, private router: Router) { }

  ok() {
    this.gameService.confirm().subscribe(() => {
      if (this.link.meta.winner) { this.router.navigate(['/Rooms']) }
    });
  }
}
