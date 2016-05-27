FactoryGirl.define do
  factory :category, class: Archangel::Category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
