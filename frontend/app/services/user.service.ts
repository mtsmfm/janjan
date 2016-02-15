import {Injectable} from 'angular2/core';
import {Http} from 'angular2/http';
import {User} from '../interfaces/game';

@Injectable()
export class UserService {
  constructor (private http: Http) {}

  getUser() {
    return this.http.get('/api/user').map(res => <User> res.json())
  }
}
