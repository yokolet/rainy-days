import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core';
import { setContext } from '@apollo/client/link/context';
import { provideApolloClient } from '@vue/apollo-composable';
// import { useToken } from '../composables/useToken';

const GRAPHQL_ENDPOINT = 'http://localhost:3906/graphql';

// TODO: use a real getJWT function once OAuth 2 starts working
// const { getJWT } = useToken();

const getJWT = (): string => 'TODO_sETRealjWt_token'

const httpLink = createHttpLink({
  uri: GRAPHQL_ENDPOINT,
});

const authLink = setContext((_, { headers }) => {
  const authToken = getJWT();
  return authToken
    ? { headers: { ...headers, authorization: `Bearer ${authToken}` }}
    : { headers };
});

const cache = new InMemoryCache();

const apolloClient = new ApolloClient({
  link: authLink.concat(httpLink),
  cache,
});

export const setupGraphQL = (): void => {
  provideApolloClient(apolloClient);
}
