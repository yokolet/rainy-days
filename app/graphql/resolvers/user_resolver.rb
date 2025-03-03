# frozen_string_literal: true

module Resolvers
  class UserResolver < BaseResolver
    type Types::UserType, null: false

    description 'Given an id, finds a user info'

    argument :id,
             type: ::GraphQL::Types::ID,
             required: true,
             description: 'User id'

    def resolve(id:)
      User.where(id: id).select(:id, :provider, :username, :image).first
    end
  end
end
