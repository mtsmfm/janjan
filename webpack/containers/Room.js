import React from 'react'
import {createFragmentContainer} from 'react-relay';
import { Redirect } from 'react-router-dom'

class Room extends React.Component {
  render() {
    if (!this.props.viewer) { return (<Redirect to="/login" />); }
    if (!this.props.viewer.room) { return (<Redirect to="/rooms" />); }

    return (
      <div>
      </div>
    );
  }
}

export default createFragmentContainer(
  Room,
  graphql`
    fragment Room_viewer on Viewer {
      id
      rooms {
        id
        usersCount
      }
    }
  `,
);
