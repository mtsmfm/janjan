import {Injectable} from 'angular2/core';
import {BaseRequestOptions} from 'angular2/http'

@Injectable()
export class ExRequestOptions extends BaseRequestOptions  {
  constructor() {
    super();
    this.headers.append('Content-Type', 'application/json');
    var token = this.getCsrfToken();
    if (token) {
      this.headers.append('X-CSRF-Token', token);
    }
  }
  getCsrfToken() {
    var meta = document.querySelector('meta[name=csrf-token]')
    if (meta) {
      return meta.getAttribute('content');
    }
  }
}
