import React from 'react';
import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';
import css from 'graphiql/graphiql.css';
import {graphQLFetcher as fetcher} from 'graphiql-subscriptions-fetcher/dist/fetcher';

class SubscriptionClient {
  constructor () {
    this.cable = ActionCable.createConsumer();
  }

  subscribe (graphQLParams, handler) {
    graphQLFetcher(graphQLParams).then(response => {
      const id = response.headers.get("x-graphql-subscription-id");
      const channel = "GraphqlChannel";
      const { query, variables } = graphQLParams;

      this.cable.subscriptions.create({ channel, id, query, variables }, {
        received: (data) => {
          handler(null, data)
          //const payloadData = parsedMessage.payload.data || null;
          //const payloadErrors = parsedMessage.payload.errors ? this.formatErrors(parsedMessage.payload.errors) : null;
          //this.subscriptions[subId].handler(payloadErrors, payloadData);
        }
      });
    });

    handler(null, "Hi!");

    return graphQLParams;
  }
}

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/graphql', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    credentials: 'same-origin',
    body: JSON.stringify(graphQLParams),
  });
}

export default class MyGraphiQL extends React.Component {
  render () {
    return (
      <div style={{height: '100vh'}}>
        <style>{css}</style>
        <GraphiQL fetcher={fetcher(new SubscriptionClient(), (params) => graphQLFetcher(params).then(response => response.json()))}/>
      </div>
    )
  }
}
