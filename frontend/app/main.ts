import {bootstrap} from 'angular2/platform/browser'
import {HTTP_PROVIDERS, RequestOptions} from 'angular2/http';
import {provide} from 'angular2/core';
import {GameComponent} from './components/game.component'
import {ExRequestOptions} from './ex-request-options'

import 'rxjs/Rx';

bootstrap(GameComponent, [
  HTTP_PROVIDERS, provide(RequestOptions, {useClass: ExRequestOptions})
])
