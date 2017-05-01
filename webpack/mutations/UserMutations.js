import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

const mutation = graphql`
  mutation UserMutationsMutation(
    $input: CreateUserInput!
  ) {
    CreateUser(input: $input) {
      viewer {
        name
        ...RoomList_viewer
      }
    }
  }
`;

export function createUser(name) {
  const variables = {
    input: {
      name
    },
  };

  commitMutation(
    environment,
    {
      mutation,
      variables
    }
  );
}
