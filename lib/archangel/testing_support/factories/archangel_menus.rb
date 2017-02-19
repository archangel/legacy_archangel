FactoryGirl.define do
  factory :menu, class: Archangel::Menu do
    sequence(:name) { |n| "Menu #{n}" }
    sequence(:slug) { |n| "menu-#{n}" }
    sequence(:attr_class) { |n| "menu-#{n}-class" }
    selected_class "selected"

    trait :deleted do
      deleted_at { Time.current }
    end

    trait :with_items do
      transient do
        item_count 2
      end

      after(:create) do |menu, evaluator|
        create_list :menu_item, evaluator.item_count, menu: menu
      end
    end
  end
end
