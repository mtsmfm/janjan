import React from 'react'
import { graphql, compose } from 'react-apollo'
import gql from 'graphql-tag'
import { Redirect } from 'react-router-dom'

class RoomList extends React.Component {
  handleCreateRoom() {
    this.props.mutate({variables: {input: {}}})
  }

  render() {
    if (this.props.data.loading) {
      return (
        <div>loading...</div>
      );
    } else if (!this.props.data.viewer) {
      return (<Redirect to="/login" />);
    } else {
      return (
        <div>
          <h1>Rooms</h1>
          <button onClick={::this.handleCreateRoom}>Create Room</button>
          <ul>
            {
              this.props.data.viewer.rooms.map(
                room => (
                  <li className="room">
                    <div className="room__id">
                    </div>
                    <div className="room__users-count">
                      {room.users_count} / 4
                    </div>
                    <button className="room__join-button">Join</button>
                  </li>
                )
              )
            }
          </ul>
        </div>
      );
    }
  }
}

export default compose(
  graphql(gql`
    query {
      viewer {
        id
        rooms {
          id
        }
      }
    }
  `),
  graphql(gql`
    mutation CreateRoom($input: CreateRoomInput!) {
      CreateRoom(input: $input) {
        viewer {
          id
          rooms {
            id
          }
        }
      }
    }
  `)
)(RoomList)
