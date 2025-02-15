# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::CommentType, type: :graphql do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:body).of_type('String!') }
  it { is_expected.to have_field(:post_id).of_type('ID!') }
  it { is_expected.to have_field(:reply_id).of_type('ID') }
  it { is_expected.to have_field(:user_id).of_type('ID!') }
  it { is_expected.to have_field(:email).of_type('String!') }
  it { is_expected.to have_field(:updated_at).of_type('ISO8601DateTime!') }
end
