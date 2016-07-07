FactoryGirl.define do
  factory :categorization, class: Archangel::Categorization do
    category
    association :categorizable, factory: :page
  end
end
