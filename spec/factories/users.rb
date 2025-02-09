FactoryBot.define do
  factory :user do
    provider { [0, 1, 2].sample }
    uid { Faker::Alphanumeric.alphanumeric }
    email { Faker::Internet.email }
    image { Faker::File.file_name(dir: 'assets/images', ext: 'jpeg') }
  end
end
