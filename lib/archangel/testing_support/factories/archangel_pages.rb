# frozen_string_literal: true

FactoryGirl.define do
  factory :page, class: Archangel::Page do
    author
    sequence(:title) { |n| "Page #{n} Title" }
    content "Content of the page"
    sequence(:slug) { |n| "page-#{n}" }
    meta_keywords "very,useful,keywords"
    meta_description "This is the default description of the page."
    published_at { Time.current }

    trait :homepage do
      homepage true
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

      after(:create) do |page, evaluator|
        create_list :tagging, evaluator.tag_count, taggable: page
      end
    end

    trait :with_categories do
      transient do
        category_count 2
      end

      after(:create) do |page, evaluator|
        create_list :categorization,
                    evaluator.category_count,
                    categorizable: page
      end
    end
  end
end
