FactoryGirl.define do
  factory :tag, class: Archangel::Tag do
    sequence(:name) { |n| "Tag #{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
