import React from 'react'
import {createFragmentContainer} from 'react-relay';
import {createRoom} from '../mutations/RoomMutations';
import { Redirect } from 'react-router-dom'

class RoomList extends React.Component {
  handleCreateRoom() {
    createRoom();
  }

  render() {
    if (!this.props.viewer) {
      return (<Redirect to="/login" />);
    }

    return (
      <div>
        <h1>Rooms</h1>
        <button onClick={::this.handleCreateRoom}>Create Room</button>
        {
          <ul>
            {
              this.props.viewer.rooms.map(
                room => (
                  <li key={room.id} className="room">
                    <div className="room__id">
                    </div>
                    <div className="room__users-count">
                      {room.usersCount} / 4
                    </div>
                    <button className="room__join-button">Join</button>
                  </li>
                )
              )
            }
          </ul>
        }
      </div>
    );
  }
}

export default createFragmentContainer(
  RoomList,
  graphql`
    fragment RoomList_viewer on Viewer {
      id
      rooms {
        id
        usersCount
      }
    }
  `,
);