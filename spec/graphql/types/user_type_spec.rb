# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::UserType, type: :graphql do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:provider).of_type('String!') }
  it { is_expected.to have_field(:email).of_type('String!') }
  it { is_expected.to have_field(:image).of_type('String') }
end
