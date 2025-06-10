FactoryBot.define do
  factory :user do
    name { Faker::Name.name }

    # メールアドレスは一意になるように sequence を使う
    sequence(:email) { |n| "user#{n}@example.com" }

    # Devise などで最低６文字以上を要求しているなら適宜
    password { "password" }
    password_confirmation { "password" }
  end
end
