import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

export function createRoom() {
  commitMutation(
    environment,
    {
      mutation: graphql`
        mutation createRoomMutation(
          $input: CreateRoomInput!
        ) {
          CreateRoom(input: $input) {
            viewer {
              ...RoomList_viewer
            }
          }
        }
      `,
      variables: {input: {}}
    }
  );
}
