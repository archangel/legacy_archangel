# frozen_string_literal: true

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

    trait :with_tags do
      transient do
        tag_count 2
      end

      after(:create) do |post, evaluator|
        create_list :tagging, evaluator.tag_count, taggable: post
      end
    end

    trait :with_categories do
      transient do
        category_count 2
      end

      after(:create) do |post, evaluator|
        create_list :categorization,
                    evaluator.category_count,
                    categorizable: post
      end
    end
  end
end
