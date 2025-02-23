# frozen_string_literal: true

module Resolvers
  class PostResolver < BaseResolver
    type Types::PostType, null: false

    description 'Get a single post'

    argument :id,
             type: ::GraphQL::Types::ID,
             required: true,
             description: 'Post id'

    def resolve(id:)
      sql = <<-SQL
select posts.id, posts.title, posts.content, posts.updated_at,
       users.id as user_id, users.provider, users.email, users.username, users.image
from posts left join users on posts.user_id = users.id
where posts.id = ?;
      SQL
      post = execute_sql(sql, [id]).map do |e|
        {
          id: e["id"],
          title: e["title"],
          content: e["content"],
          updated_at: e["updated_at"],
          user: {
            id: e["user_id"],
            provider: User.providers.invert[e["provider"]],
            email: e["email"],
            username: e["username"],
            image: e["image"]
          }
        }
      end.first

      if post.blank?
        raise GraphQL::ExecutionError.new(
          GraphqlErrorType::ARGUMENT_ERROR,
          extensions: { code: GraphqlErrorType::ARGUMENT_ERROR }
        )
      end

      sql = <<-SQL
select
    comments.id, comments.body, comments.post_id, comments.reply_id,
    comments.user_id, users.email, users.username,
    comments.updated_at
from comments left join users on comments.user_id = users.id
where post_id = ?;
      SQL
      comments = execute_sql(sql, [id])
      post[:comments] = comments
      post
    rescue => e
      raise GraphQL::ExecutionError.new(
        e.message,
        extensions: {
          code: (e.respond_to?(:extensions) && e.extensions[:code]) || GraphqlErrorType::INTERNAL_SERVER_ERROR
        })
    end

    private

    def execute_sql(sql, params)
      cleaned_sql = Post.sanitize_sql_array([sql, *params])
      ActiveRecord::Base.connection.execute(cleaned_sql).map {|e| e}
    end
  end
end
