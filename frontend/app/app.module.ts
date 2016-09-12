import {BrowserModule} from '@angular/platform-browser';
import {FormsModule}   from '@angular/forms';
import {ExRequestOptions} from './ex-request-options'
import {RouterModule, Routes} from '@angular/router';
import {HttpModule, RequestOptions} from '@angular/http';
import {UserService} from './services/user.service';
import {NgModule} from '@angular/core';

import {AppComponent} from './components/app.component';
import {GameComponent} from './components/game.component';
import {GameBoardComponent} from './components/game-board.component';
import {GameDialogComponent} from './components/game-dialog.component';
import {GameInfoComponent} from './components/game-info.component';
import {HandComponent} from './components/hand.component';
import {LoginFormComponent} from './components/login-form.component';
import {RiverComponent} from './components/river.component';
import {RoomComponent} from './components/room.component';
import {RoomListComponent} from './components/room-list.component';
import {UserFieldComponent} from './components/user-field.component';
import {UserInfoComponent} from './components/user-info.component';

import 'rxjs/Rx';

const routes: Routes = [
  {path: 'rooms', pathMatch: 'full', component: RoomListComponent},
  {path: 'room',  pathMatch: 'full', component: RoomComponent},
  {path: 'game',  pathMatch: 'full', component: GameComponent},
  {path: 'login', pathMatch: 'full', component: LoginFormComponent},
  {path: '',      pathMatch: 'full', redirectTo: 'login'},
]

@NgModule({
  imports:      [ RouterModule, HttpModule, BrowserModule, FormsModule, RouterModule.forRoot(routes) ],
  declarations: [ AppComponent, GameComponent, GameBoardComponent, GameDialogComponent, GameInfoComponent, HandComponent, LoginFormComponent, RiverComponent, RoomComponent, RoomListComponent, UserFieldComponent, UserInfoComponent ],
  bootstrap:    [ AppComponent ],
  providers: [
    UserService,
    {provide: RequestOptions, useClass: ExRequestOptions}
  ]
})
export class AppModule { }
