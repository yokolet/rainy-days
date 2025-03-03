import gql from 'graphql-tag';

export const POST_QUERY = gql`
    query Post ($id: ID!){
        post(id: $id) {
            id
            title
            content
            updatedAt
            comments {
                id
                body
                postId
                replyId
                updatedAt
                username
            }
            user {
                id
                username
                provider
                image
            }
        }
    }
`
