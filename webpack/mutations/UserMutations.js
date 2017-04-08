import Relay from 'react-relay';

export default class extends Relay.Mutation {
  getMutation() {
    return Relay.QL`mutation { CreateUser }`;
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateUserPayload {
        viewer {
          user {
            id
          }
        }
      }
    `;
  }

  getConfigs() {
    return [
      {
        type: 'REQUIRED_CHILDREN',
        children: [
          Relay.QL`
            fragment on CreateUserPayload {
              viewer {
                user {
                  id
                }
              }
            }
          `,
        ],
      }
      // {
      //   type: 'REQUIRED_CHILDREN',
      //   fieldIDs: {
      //     viewer: {
      //       user: this.props.viewer.user
      //     }
      //   },
      // }
    ];
  }

  getVariables() {
    return {
      name: this.props.name
    };
  }
}
