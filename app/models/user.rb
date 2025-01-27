class User < ApplicationRecord
  # validation
  validates_presence_of :provider, :email, :uid
  validates_uniqueness_of :email, scope: :provider
end
