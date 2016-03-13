FactoryGirl.define do
  factory :page, class: Archangel::Page do
    sequence(:title) { |n| "Page #{n} Title" }
    content "Content of the page"
    sequence(:slug) { |n| "page#{n}" }
    author
    published_at { Time.current }

    trait :homepage do
      slug "home"
    end
  end
end
