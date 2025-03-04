import {
  ApolloClient,
  createHttpLink,
  InMemoryCache,
} from "@apollo/client/core"
import { setContext } from "@apollo/client/link/context"
import { provideApolloClient } from "@vue/apollo-composable"

const GRAPHQL_ENDPOINT = `${window.location.protocol}//${window.location.host}/graphql`

const getJWT = (): string => "TODO_sETRealjWt_token"

const httpLink = createHttpLink({
  uri: GRAPHQL_ENDPOINT,
})

const authLink = setContext((_, { headers }) => {
  const authToken = getJWT()
  return authToken
    ? { headers: { ...headers, authorization: `Bearer ${authToken}` } }
    : { headers }
})

const cache = new InMemoryCache()

const apolloClient = new ApolloClient({
  link: authLink.concat(httpLink),
  cache,
})

export const setupGraphQL = (): void => {
  provideApolloClient(apolloClient)
}
