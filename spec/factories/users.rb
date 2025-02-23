FactoryBot.define do
  factory :user do
    provider { [:google, :github, :gitlab].sample }
    username { Faker::Internet.username(specifier: 5..30) }
    email { Faker::Internet.email }
    image { Faker::File.file_name(dir: 'assets/images', ext: 'jpeg') }
  end
end
