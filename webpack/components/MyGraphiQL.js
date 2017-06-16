import React from 'react';
import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';
import css from 'graphiql/graphiql.css';
import {graphQLFetcher as fetcher} from 'graphiql-subscriptions-fetcher/dist/fetcher';
import {SubscriptionClient, graphQLFetcher} from '../SubscriptionClient';

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
