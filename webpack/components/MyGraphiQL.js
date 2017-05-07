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
      response.json().then(data => {
        if (data.errors) {
          handler(null, data);
          return;
        }

        const id = response.headers.get("x-graphql-subscription-id");
        const channel = "GraphqlChannel";

        this.subscription = this.cable.subscriptions.create({ channel, id }, {
          received: (payload) => {
            handler(null, payload);
          }
        });

        handler(null, "Your subscription data will appear here after server publication!");
      })
    });

    return graphQLParams;
  }

  unsubscribe () {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
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
        <style>{css.toString()}</style>
        <GraphiQL fetcher={fetcher(new SubscriptionClient(), (params) => graphQLFetcher(params).then(response => response.json()))}/>
      </div>
    )
  }
}
