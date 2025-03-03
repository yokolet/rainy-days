# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :post_id, ID, null: false
    field :reply_id, ID
    field :username, String, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
