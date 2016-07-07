FactoryGirl.define do
  factory :user, aliases: [:author, :uploader], class: Archangel::User do
    sequence(:name) { |n| "User #{n}" }
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    sequence(:confirmation_token) { |n| "token-#{n}" }
    confirmed_at { Time.current }
    confirmation_sent_at { Time.current }

    trait :avatar do
      avatar { File.new(uploader_test_image) }
    end

    trait :unconfirmed do
      confirmation_token nil
      confirmed_at nil
      confirmation_sent_at nil
    end

    trait :reset do
      reset_password_token "abc123"
      reset_password_sent_at { Time.current }
    end

    trait :locked do
      failed_attempts 10
      unlock_token "123abc"
      locked_at { Time.current }
    end

    trait :tracks do
      sign_in_count 2
      current_sign_in_at { Time.current }
      last_sign_in_at { 1.day.ago.to_date }
      current_sign_in_ip "127.0.0.1"
      last_sign_in_ip "127.0.0.1"
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
