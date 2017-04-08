import React from 'react';
import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';
import css from 'graphiql/graphiql.css';

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/graphql', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    credentials: 'same-origin',
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

export default class MyGraphiQL extends React.Component {
  render () {
    return (
      <div style={{height: '100vh'}}>
        <style>{css}</style>
        <GraphiQL fetcher={graphQLFetcher}/>
      </div>
    )
  }
}
