import {BrowserModule} from '@angular/platform-browser';
import {FormsModule}   from '@angular/forms';
import {ExHeaders} from './ex-headers';
import {ROUTER_PROVIDERS} from '@angular/router-deprecated';
import {AppComponent}  from './components/app.component';
import {HTTP_PROVIDERS, RequestOptions, Headers} from '@angular/http';
import {UserService} from './services/user.service';
import {appInjector} from './app-injector';
import {NgModule, ComponentRef, APP_BOOTSTRAP_LISTENER} from '@angular/core';
import {DefaultApi, BASE_PATH} from './client';

import 'rxjs/Rx';

@NgModule({
  imports:      [ BrowserModule, FormsModule ],
  declarations: [ AppComponent ],
  bootstrap:    [ AppComponent ],
  providers: [
    UserService,
    ROUTER_PROVIDERS,
    HTTP_PROVIDERS,
    {provide: BASE_PATH, useValue: 'http://lvh.me:3000/api'},
    {provide: Headers, useClass: ExHeaders},
    DefaultApi,
    {
      provide: APP_BOOTSTRAP_LISTENER,
      multi: true,
      useValue: (cmp: ComponentRef<any>) => {
        appInjector(cmp.injector);
      }
    }
  ]
})
export class AppModule { }
