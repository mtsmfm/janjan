import React from 'react';
import {QueryRenderer, graphql} from 'react-relay';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import environment from '../environment';

export default class App extends React.Component {
  render() {
    return (
      <QueryRenderer
        environment={environment}
        query={graphql`
          query AppQuery {
            viewer {
              id
            }
          }
        `}
        render={({error, props}) => {
          if (error) {
            return <div>{error.message}</div>;
          } else if (props) {
            return <div>{props.viewer} is great!</div>;
          }
          return <div>Loading</div>;
        }}
      />
    );
  }
}
