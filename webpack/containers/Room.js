import React from 'react'
import {createFragmentContainer} from 'react-relay';
import { Redirect } from 'react-router-dom'

class Room extends React.Component {
  render() {
    if (!this.props.viewer) { return (<Redirect to="/login" />); }
    if (!this.props.viewer.room) { return (<Redirect to="/rooms" />); }

    const room = this.props.viewer.room;

    return (
      <div>
        <h1>Room {room.id}</h1>
        <ul>
          {
            room.users.map(user =>(
              <li key={user.id}>
                {user.name}
              </li>
            ))
          }
        </ul>
        <button>Start</button>
      </div>
    );
  }
}

export default createFragmentContainer(
  Room,
  graphql`
    fragment Room_viewer on Viewer {
      id
      room {
        id
        users {
          id, name
        }
      }
    }
  `,
);
