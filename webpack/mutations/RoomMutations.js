import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

export function createRoom() {
  const variables = {input: {}};

  commitMutation(
    environment,
    {
      graphql`
        mutation RoomMutationsMutation(
          $input: CreateRoomInput!
        ) {
          CreateRoom(input: $input) {
            viewer {
              ...RoomList_viewer
            }
          }
        }
      `,
      variables
    }
  );
}
