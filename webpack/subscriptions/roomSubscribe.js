import { requestSubscription, graphql } from 'react-relay';
import environment from '../environment';

export default function roomSubscribe(id) {
  requestSubscription(
    environment,
    {
      subscription: graphql`
        subscription roomSubscribeSubscription {
          roomSubscribe {
            mutation
            node {
              id, usersCount
            }
          }
        }
      `,
      variables: {},
      updater: () => {
        debugger;
      }
    }
  );
}
