import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

export function joinRoom(id) {
  commitMutation(
    environment,
    {
      mutation: graphql`
        mutation joinRoomMutation(
          $input: JoinRoomInput!
        ) {
          JoinRoom(input: $input) {
            viewer {
              ...Room_viewer
            }
          }
        }
      `,
      variables: {input: {id}}
    }
  );
}
