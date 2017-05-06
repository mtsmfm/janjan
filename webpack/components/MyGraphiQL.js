import React from 'react';
import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';
import css from 'graphiql/graphiql.css';
import {graphQLFetcher as fetcher} from 'graphiql-subscriptions-fetcher/dist/fetcher';

class SubscriptionClient {
  constructor () {
    this.cable = ActionCable.createConsumer();
  }

  subscribe (options, handler) {
    const { query, variables, operationName, context } = options;
    const channel = "TestChannel";

    this.cable.subscriptions.create({ channel, query, variables }, {
      received: (data) => {
        debugger;
        //const payloadData = parsedMessage.payload.data || null;
        //const payloadErrors = parsedMessage.payload.errors ? this.formatErrors(parsedMessage.payload.errors) : null;
        //this.subscriptions[subId].handler(payloadErrors, payloadData);
      }
    });

    handler(null, "Hi!");

    return { query, variables };
  }
}

const cable = ActionCable.createConsumer();

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/graphql', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    credentials: 'same-origin',
    body: JSON.stringify(graphQLParams),
  }).then(response => {
    if (response.headers.has("x-graphql-subscription-channel")) {
      const channel = response.headers.get("x-graphql-subscription-channel");
      const { query, variables } = graphQLParams;

      return {
        subscribe: observer => {
          cable.subscriptions.create({ channel, query, variables }, {
            received: (data) => {
              observer.next(data);
            }
          })
        }
      }
    } else {
      return response.json();
    }
  });
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
