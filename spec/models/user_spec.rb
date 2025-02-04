require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:email).scoped_to(:provider) }
end
