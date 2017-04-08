import React from 'react';
import Relay from 'react-relay';
import UserMutations from '../mutations/UserMutations';

class LoginForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {name: ''};

    this.handleChange = this.handleChange.bind(this);
    this.login = this.login.bind(this);
  }

  login(event) {
    event.preventDefault();

    Relay.Store.commitUpdate(new UserMutations({
      viewer: this.props.viewer,
      name: this.state.name
    }));
  }

  handleChange(event) {
    this.setState({name: event.target.value});
  }

  render() {
    const {user} = this.props.viewer;
    let userArea;
    if (user) {
      userArea = (
        <div>
          {user.id} : {user.name}
        </div>
      );
    }

    return (
      <form onSubmit={this.login}>
        {userArea}
        <input value={this.state.name} onChange={this.handleChange}/>
        <button type="submit">Login</button>
      </form>
    );
  }
}

export default Relay.createContainer(LoginForm, {
  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        user {
          id, name
        }
      }
    `,
  },
});
