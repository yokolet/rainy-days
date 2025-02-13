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
                email
                postId
                replyId
                updatedAt
                userId
            }
            user {
                id
                email
                provider
                image
            }
        }
    }
`
