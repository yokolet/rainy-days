class User < ApplicationRecord
  enum :provider, { google: 0, github: 1, gitlab: 2 }

  # validation
  validates_presence_of :provider, :email, :username
  validates_uniqueness_of :email, case_insensitive: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
