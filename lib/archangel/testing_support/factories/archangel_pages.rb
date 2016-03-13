FactoryGirl.define do
  factory :page, class: Archangel::Page do
    title "Page Title"
    content "Content of the page"
    sequence(:path) { |n| "page#{n}" }
    author
    published_at { Time.current }

    trait :homepage do
      path "home"
    end
  end
end
