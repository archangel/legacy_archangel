FactoryGirl.define do
  factory :menu_item, class: Archangel::MenuItem do
    menu
    sequence(:label) { |n| "Menu Item #{n}" }
    sequence(:attr_class) { |n| "menu-item-#{n}-class" }
    url "http://example.com"
    position 1

    trait :menuable do
      association :menuable, factory: :page
      url nil
    end

    trait :deleted do
      deleted_at { Time.current }
    end

    trait :with_children do
      transient do
        item_count 2
      end

      after(:create) do |menu, evaluator|
        create_list :menu_item,
                    evaluator.item_count,
                    parent_id: menu.id,
                    menu_id: evaluator.menu.id
      end
    end
  end
end
