FactoryGirl.define do
  factory :page, class: Archangel::Page do
    title "Page Title"
    content "Content of the page"
    sequence(:path) { |n| "page#{n}" }

    trait :homepage do
      path ""
    end
  end
end
