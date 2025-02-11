FactoryBot.define do
  factory :user do
    provider { [:google, :github, :gitlab].sample }
    uid { Faker::Alphanumeric.alphanumeric }
    email { Faker::Internet.email }
    image { Faker::File.file_name(dir: 'assets/images', ext: 'jpeg') }
  end
end
