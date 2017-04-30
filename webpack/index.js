import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import MyGraphiQL from './components/MyGraphiQL';
import App from './containers/App';

ReactDOM.render(
  <Router>
    <div>
      <ul>
        <li><Link to="/">Home</Link></li>
        <li><Link to="/graphiql">GraphiQL</Link></li>
      </ul>

      <hr/>

      <Route path="/" component={App}/>
      <Route path="/graphiql" component={MyGraphiQL}/>
    </div>
  </Router>,
  document.getElementById('root')
);
