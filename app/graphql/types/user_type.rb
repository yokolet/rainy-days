# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :provider, String, null: false
    field :email, String, null: false
    field :image, String
  end
end
