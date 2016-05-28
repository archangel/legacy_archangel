FactoryGirl.define do
  factory :page, class: Archangel::Page do
    sequence(:title) { |n| "Page #{n} Title" }
    content "Content of the page"
    author
    sequence(:slug) { |n| "page-#{n}" }
    meta_keywords "very, useful, keywords"
    meta_description "This is the default description of the site."
    published_at { Time.current }

    trait :homepage do
      slug "home"
    end

    trait :unpublished do
      published_at nil
    end

    trait :future do
      published_at { Time.current + 1.week }
    end
  end
end
