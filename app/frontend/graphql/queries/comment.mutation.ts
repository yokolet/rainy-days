import gql from 'graphql-tag';

export const COMMENT_MUTATION = gql`
    mutation comment($body: String!, $pid: ID!, $rid: ID) {
        commentCreate(input: {
            body: $body,
            postId: $pid,
            replyId: $rid
        }) {
            comment {
                id
                body
                postId
                replyId
                userId
                email
                updatedAt
            }
        }
    }
`
