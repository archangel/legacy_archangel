# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Navigation", type: :feature do
  describe "when no menu is returned" do
    let!(:custom_page) { create(:page) }

    it "builds an empty menu" do
      visit archangel.frontend_page_path(custom_page.path)

      within("nav#navigation") do
        expect(page).to have_css("ul")

        within("ul") do
          expect(page).to have_no_selector("li")
        end
      end
    end
  end

  describe "when menu has no items" do
    let!(:custom_page) { create(:page) }
    let!(:menu) { create(:menu) }

    it "builds menu container without items" do
      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_no_selector("li")
      end
    end
  end

  describe "menu with items" do
    let!(:custom_page) { create(:page) }
    let!(:menu) { create(:menu) }

    it "with external link" do
      item = create(:menu_item, menu: menu, url: "https://example.com")

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 1)

        expect(page).to have_css("li.#{item.attr_class}")
        within("li.#{item.attr_class}") do
          expect(page).to have_link(item.label, href: item.url)
        end
      end
    end

    it "with Menuable Page link" do
      item = create(:menu_item, menu: menu, menuable: custom_page, url: nil)

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 1)

        expect(page).to have_css("li.#{item.attr_class}")
        within("li.#{item.attr_class}") do
          expect(page).to(
            have_link(item.label,
                      href: archangel.frontend_page_path(custom_page.path))
          )
        end
      end
    end

    it "with Menuable Post link" do
      post = create(:post)
      item = create(:menu_item, menu: menu, menuable: post, url: nil)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 1)

        expect(page).to have_css("li.#{item.attr_class}")
        within("li.#{item.attr_class}") do
          expect(page).to(
            have_link(item.label, href: archangel.frontend_page_path(post.path))
          )
        end
      end
    end

    it "builds one level of items" do
      items = create_list(:menu_item, 2, menu: menu)

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: items.count)

        expect(page).to have_css("li.#{items.first.attr_class}")
        within("li.#{items.first.attr_class}") do
          expect(page).to have_link(items.first.label, href: items.first.url)
        end

        expect(page).to have_css("li.#{items.last.attr_class}")
        within("li.#{items.last.attr_class}") do
          expect(page).to have_link(items.last.label, href: items.last.url)
        end
      end
    end

    it "builds with two level of items" do
      item_a = create(:menu_item, menu: menu)
      item_a_b = create(:menu_item, menu: menu, parent: item_a)

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")
      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 2)

        expect(page).to have_css("li.#{item_a.attr_class}.dropdown")
        within("li.#{item_a.attr_class}") do
          expect(page).to have_link(item_a.label, href: item_a.url)

          expect(page).to have_css("li", count: 1)

          expect(page).to have_css("li.#{item_a_b.attr_class}")
          within("li.#{item_a_b.attr_class}") do
            expect(page).to have_link(item_a_b.label, href: item_a_b.url)
          end
        end
      end
    end

    it "builds with three levels of items" do
      item_a = create(:menu_item, menu: menu)
      item_a_b = create(:menu_item, menu: menu, parent: item_a)
      item_a_b_c = create(:menu_item, menu: menu, parent: item_a_b)

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")
      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 3)

        expect(page).to have_css("li.#{item_a.attr_class}.dropdown")
        within("li.#{item_a.attr_class}") do
          expect(page).to have_link(item_a.label, href: item_a.url)

          expect(page).to have_css("li", count: 2)

          expect(page).to have_css("li.#{item_a_b.attr_class}")
          within("li.#{item_a_b.attr_class}") do
            expect(page).to have_link(item_a_b.label, href: item_a_b.url)

            expect(page).to have_css("li", count: 1)

            expect(page).to have_css("li.#{item_a_b_c.attr_class}")
            within("li.#{item_a_b_c.attr_class}") do
              expect(page).to have_link(item_a_b_c.label, href: item_a_b_c.url)
            end
          end
        end
      end
    end
  end

  describe "with inactive page items" do
    let!(:custom_page) { create(:page) }
    let!(:menu) { create(:menu) }

    it "still builds the menu item" do
      item = create(:menu_item, menu: menu, menuable: custom_page, url: nil)

      custom_page.update(deleted_at: Time.current)

      visit archangel.frontend_page_path(custom_page.path)

      expect(page).to have_css("ul.#{menu.attr_class}")

      within("ul.#{menu.attr_class}") do
        expect(page).to have_css("li", count: 1)

        expect(page).to have_css("li.#{item.attr_class}")
        within("li.#{item.attr_class}") do
          expect(page).to have_css("span", text: item.label)
        end
      end
    end
  end

  it "has full custom menu" do
    custom_page = create(:page)
    menu = create(:menu, attr_id: "menu_id",
                         attr_class: "menu_class",
                         selected_class: "item_selected")
    item = create(:menu_item, menu: menu,
                              attr_id: "custom_id",
                              attr_class: "custom_class",
                              link_attr_class: "custom_link_class",
                              menuable: custom_page,
                              url: nil)

    visit archangel.frontend_page_path(custom_page.path)

    expect(page).to have_css("ul##{menu.attr_id}.#{menu.attr_class}")

    within("ul##{menu.attr_id}.#{menu.attr_class}") do
      expect(page).to have_css("li", count: 1)

      expect(page).to have_css("li##{item.attr_id}.#{item.attr_class}")
      expect(page).to have_css("li.item_selected.active-leaf")
      within("li##{item.attr_id}.#{item.attr_class}") do
        expect(page).to(
          have_css("a.#{item.link_attr_class}.#{menu.selected_class}")
        )
        expect(page).to(
          have_link(item.label,
                    href: archangel.frontend_page_path(custom_page.path))
        )
      end
    end
  end
end
