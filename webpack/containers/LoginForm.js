import React from 'react';
import {createFragmentContainer} from 'react-relay';
import {createUser} from '../mutations/UserMutations';
import { Redirect } from 'react-router-dom'

class LoginForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {name: ''};
  }

  login(event) {
    event.preventDefault();

    createUser(this.state.name);
  }

  handleChange(event) {
    this.setState({name: event.target.value});
  }

  render() {
    if (this.props.viewer) {
      return <Redirect to="/rooms" />;
    }

    return (
      <form onSubmit={::this.login}>
        <input value={this.state.name} onChange={::this.handleChange}/>
        <button type="submit">Login</button>
      </form>
    );
  }
}

export default createFragmentContainer(
  LoginForm,
  graphql`
    fragment LoginForm_viewer on Viewer {
      id, name
    }
  `,
);
