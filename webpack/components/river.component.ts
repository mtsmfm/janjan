import {Component} from '@angular/core';
import {River} from '../interfaces/game';

@Component({
  selector: 'river',
  inputs: ['river'],
  template: `
    <ul class="river">
      <li *ngFor="let tile of river.tiles" class="tile" attr.data-tile="{{tile.kind}}">
      </li>
    </ul>
  `
})

export class RiverComponent {
  public river: River;
}
