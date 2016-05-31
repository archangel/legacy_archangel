FactoryGirl.define do
  factory :categorization, class: Archangel::Categorization do
    category
    association :categorizable, factory: :post
  end
end
