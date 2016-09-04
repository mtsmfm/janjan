import {Observable} from 'rxjs/Observable';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Injectable} from '@angular/core';
import {DefaultApi, User} from '../client';

@Injectable()
export class UserService {
  public user$: BehaviorSubject<User>;
  constructor (private api: DefaultApi) {
    this.user$ = new BehaviorSubject(null);
  }
  createUser(name: string) {
    return this.api.userPost(name).
      do(data => this.user$.next(data)).publish().refCount();
  }
  loadUser() {
    return this.api.userGet().
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
