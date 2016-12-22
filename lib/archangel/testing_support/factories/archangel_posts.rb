FactoryGirl.define do
  factory :post, class: Archangel::Post do
    author
    sequence(:title) { |n| "Post #{n} Title" }
    sequence(:slug) { |n| "post-#{n}-title" }
    content "Content of the post"
    meta_keywords "very, useful, keywords"
    meta_description "This is the default description of the post."
    published_at { Time.current }

    trait :feature do
      feature { File.new(uploader_test_image) }
    end

    trait :unpublished do
      published_at nil
    end

    trait :future do
      published_at { Time.current + 1.week }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
