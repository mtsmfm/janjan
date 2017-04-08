import React from 'react';
import Relay from 'react-relay';
import LoginForm from './LoginForm';

class App extends React.Component {
  render() {
    return (
      <div>
        <LoginForm viewer={this.props.viewer}/>
        <h1>User list</h1>
        <ul>
          {this.props.viewer.users.map(user =>
            <li key={user.id}>{user.name} (ID: {user.id})</li>
          )}
        </ul>
      </div>
    );
  }
}

export default Relay.createContainer(App, {
  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        ${LoginForm.getFragment('viewer')}

        users {
          id, name
        }
      }
    `,
  },
});
