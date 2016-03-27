import {Observable} from 'rxjs/Observable';
import {BehaviorSubject} from 'rxjs/subject/BehaviorSubject';
import {Injectable} from 'angular2/core';
import {Http} from 'angular2/http';
import {User} from '../interfaces/game';

@Injectable()
export class UserService {
  public user$: BehaviorSubject<User>;
  constructor (private http: Http) {
    this.user$ = new BehaviorSubject(null);
  }
  createUser(name: string) {
    return this.http.post('/api/user', JSON.stringify({name: name})).
      map(res => <User> res.json().user).
      do(data => this.user$.next(data)).publish().refCount();
  }
  loadUser() {
    return this.http.get('/api/user').
      catch(res => {
        if (res.status === 404) {
          return Observable.of({json: () => { return({user: null}) }})
        } else {
          throw(res)
        }
      }).
      map(res => <User> res.json().user).
      do(data => this.user$.next(data)).publish().refCount();
  }
}
