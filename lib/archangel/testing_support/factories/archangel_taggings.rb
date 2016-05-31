FactoryGirl.define do
  factory :tagging, class: Archangel::Tagging do
    tag
    association :taggable, factory: :post
  end
end
