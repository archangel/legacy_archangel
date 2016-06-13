FactoryGirl.define do
  factory :post, class: Archangel::Post do
    sequence(:title) { |n| "Post #{n} Title" }
    content "Content of the post"
    excerpt "Content of the excerpt"
    sequence(:slug) { |n| "post-#{n}-title" }
    author
    published_at { Time.current }

    trait :unpublished do
      published_at nil
    end

    trait :future do
      published_at { Time.current + 1.week }
    end

    trait :with_comments do
      transient do
        comment_count 3
      end

      after(:create) do |item, evaluator|
        create_list(:comment, evaluator.comment_count, commentable: item)
      end
    end
  end
end
