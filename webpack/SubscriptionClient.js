export function graphQLFetcher(graphQLParams) {
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

export class SubscriptionClient {
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
