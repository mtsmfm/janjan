import { commitMutation, graphql } from 'react-relay';
import environment from '../environment';

const mutation = graphql`
  mutation UserMutationsMutation(
    $input: CreateUserInput!
  ) {
    CreateUser(input: $input) {
      viewer {
        id, name
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
      variables,
      onCompleted: (response) => {
        console.log('Success!')
      },
      onError: err => console.error(err),
    },
  );
}
