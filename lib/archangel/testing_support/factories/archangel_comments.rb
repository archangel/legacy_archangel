FactoryGirl.define do
  factory :comment, class: Archangel::Comment do
    association :commentable, factory: :post
    author
    content "This is my comment."
    approved_at { Time.current }

    factory :parent_comment do
      after(:create) { |c, evaluator| create(:comment, parent: c) }
    end

    factory :child_comment do
      association :parent, factory: :comment
    end

    trait :guest do
      sequence(:name) { |n| "Guest #{n}" }
      sequence(:email) { |n| "guest#{n}@example.com" }
      author nil
    end

    trait :unapproved do
      approved_at nil
    end
  end
end
