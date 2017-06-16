import React from 'react';
import {QueryRenderer, graphql} from 'react-relay';
import {BrowserRouter as Router, Route, Link} from 'react-router-dom';
import environment from '../environment';
import LoginForm from './LoginForm';
import RoomList from './RoomList';
import Room from './Room';

export default class App extends React.Component {
  render() {
    return (
      <QueryRenderer
        environment={environment}
        query={graphql`
          query AppQuery {
            viewer {
              id
              ...LoginForm_viewer
              ...RoomList_viewer
              ...Room_viewer
            }
          }
        `}
        render={({error, props}) => {
          if (error) {
            return <div>{error.message}</div>;
          } else if (props) {
            return(
              <Router>
                <div>
                  <Route exact path="/" render={() => <LoginForm viewer={props.viewer}/>} />
                  <Route exact path="/login" render={() => <LoginForm viewer={props.viewer}/>} />
                  <Route exact path="/rooms" render={() => <RoomList viewer={props.viewer}/>} />
                  <Route exact path="/room" render={() => <Room viewer={props.viewer}/>} />
                </div>
              </Router>
            )
          }
          return <div>Loading</div>;
        }}
      />
    );
  }
}
