import {bootstrap} from 'angular2/platform/browser'
import {HTTP_PROVIDERS, RequestOptions} from 'angular2/http';
import {ROUTER_PROVIDERS} from 'angular2/router';
import {provide, ComponentRef} from 'angular2/core';
import {AppComponent} from './components/app.component'
import {ExRequestOptions} from './ex-request-options'
import {UserService} from './services/user.service';
import {appInjector} from './app-injector';

import 'rxjs/Rx';

bootstrap(AppComponent, [
  UserService, ROUTER_PROVIDERS, HTTP_PROVIDERS, provide(RequestOptions, {useClass: ExRequestOptions})
]).then((appRef: ComponentRef) => {
  // store a reference to the injector
  appInjector(appRef.injector);
})
