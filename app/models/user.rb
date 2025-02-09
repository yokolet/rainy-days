class User < ApplicationRecord
  enum :provider, [:google, :github, :gitlab]

  # validation
  validates_presence_of :provider, :email, :uid
  validates_uniqueness_of :email, case_insensitive: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
