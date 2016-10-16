import {Injectable} from '@angular/core';
import {Headers} from '@angular/http'

@Injectable()
export class ExHeaders extends Headers {
  constructor() {
    super();
    //this.append('Content-Type', 'application/json');
    var token = this.getCsrfToken();
    if (token) {
      this.append('X-CSRF-Token', token);
    }
  }
  getCsrfToken() {
    var meta = document.querySelector('meta[name=csrf-token]')
    if (meta) {
      return meta.getAttribute('content');
    }
  }
}
