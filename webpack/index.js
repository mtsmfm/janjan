// @flow

import App from './components/App';
import AppHomeRoute from './routes/AppHomeRoute';
import MyGraphiQL from './components/MyGraphiQL';
import React from 'react';
import ReactDOM from 'react-dom';
import Relay from 'react-relay';
import { Router, Route, Link, applyRouterMiddleware, browserHistory } from 'react-router';
import useRelay from 'react-router-relay';

ReactDOM.render(
  <Router
    history={browserHistory}
    render={applyRouterMiddleware(useRelay)}
    environment={Relay.Store}
  >
    <Route
      path="/graphiql"
      component={MyGraphiQL}
    >
    </Route>
  </Router>,
  document.getElementById('root')
);
