FactoryBot.define do
  factory :reservation do
    association :user
    association :skill_offering

    # 必須項目
    reserved_date { Date.today + rand(1..7) }          # 1～7日後の日付
    reserved_time { Time.zone.parse("10:00") }        # 任意の時刻、必要に応じて動的に

    message { Faker::Lorem.sentence }                 # 必須なので必ず何か入れる

    # status はデフォルト "pending" が DB 側で入るので省略可
    # trait で状態を切り替えたい場合
    trait :approved do
      status { "approved" }
    end

    trait :cancelled do
      status { "cancelled" }
    end
  end
end
