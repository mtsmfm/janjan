import React from 'react'
import {createFragmentContainer} from 'react-relay';
import {createRoom} from '../mutations/createRoom';
import {joinRoom} from '../mutations/joinRoom';
import roomSubscribe from '../subscriptions/roomSubscribe';
import { Redirect } from 'react-router-dom'

const Room = function(props) {
  return (
    <li className="room">
      <div className="room__id">
      </div>
      <div className="room__users-count">
        {props.room.usersCount} / 4
      </div>
      <button className="room__join-button" onClick={() => joinRoom(props.room.id)}>Join</button>
    </li>
  );
}

class RoomList extends React.Component {
  componentDidMount() {
    roomSubscribe();
  }

  handleCreateRoom() {
    createRoom();
  }

  render() {
    if (!this.props.viewer) { return (<Redirect to="/login" />); }
    if (this.props.viewer.room) { return (<Redirect to="/room" />); }

    return (
      <div>
        <h1>Rooms</h1>
        <button onClick={::this.handleCreateRoom}>Create Room</button>
        {
          <ul>
            {this.props.viewer.rooms.map(room => <Room room={room} key={room.id} />)}
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
      room {
        id
      }
      rooms {
        id
        usersCount
      }
    }
  `,
);
