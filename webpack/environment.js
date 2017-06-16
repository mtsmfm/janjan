import { Environment, Network, RecordSource, Store } from 'relay-runtime';
import {SubscriptionClient, graphQLFetcher} from './SubscriptionClient';

// Define a function that fetches the results of an operation (query/mutation/etc)
// and returns its results as a Promise:
function fetchQuery(
  operation,
  variables,
  cacheConfig,
  uploadables,
) {
  return graphQLFetcher({
    query: operation.text, // GraphQL text from input
    variables,
  }).then(response => response.json());
}

function subscribe(
  operation,
  variables,
  cacheConfig,
  observer,
) {
  const subscriptionClient = new SubscriptionClient();

  subscriptionClient.subscribe({
    query: operation.text,
    variables
  }, (error, result) => {
    if (error) {
      observer.onError(error);
    } else {
      observer.onNext(result)
    }
  });

  return {
    dispose: () => subscriptionClient.unsubscribe()
  }
}

const network = Network.create(fetchQuery, subscribe);
const source = new RecordSource();
const store = new Store(source);

const environment = new Environment({
  store,
  network,
});

export default environment;
