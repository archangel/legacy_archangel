FactoryGirl.define do
  factory :tag, class: Archangel::Tag do
    sequence(:name) { |n| "Tag #{n}" }
    sequence(:slug) { |n| "tag-#{n}" }
    description "Description of the tag"
  end
end
