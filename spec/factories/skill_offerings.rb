FactoryBot.define do
  factory :skill_offering do
    association :user
    association :category

    title          { Faker::Lorem.sentence(word_count: 3) }
    available_time { "平日 10:00-20:00" }
    details        { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
