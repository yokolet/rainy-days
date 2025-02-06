# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :user, UserType, null: false
    field :comments, [CommentType], null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
