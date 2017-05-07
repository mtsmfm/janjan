import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

const mutation = graphql`
  mutation RoomMutationsMutation(
    $input: CreateRoomInput!
  ) {
    CreateRoom(input: $input) {
      viewer {
        ...RoomList_viewer
      }
    }
  }
`;

export function createRoom() {
  const variables = {input: {}};

  commitMutation(
    environment,
    {
      mutation,
      variables
    }
  );
}
