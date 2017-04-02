# frozen_string_literal: true

module Archangel
  # MenuItem model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class MenuItem < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :position
    acts_as_paranoid

    after_initialize :column_default

    validates :menu_id, presence: true
    validates :label, presence: true
    validates :method, allow_blank: true,
                       inclusion: { in: Archangel::MENU_METHODS }

    belongs_to :menu
    belongs_to :menuable, polymorphic: true
    belongs_to :parent, class_name: Archangel::MenuItem

    has_many :menu_items, foreign_key: :parent_id,
                          source: :parent,
                          dependent: :destroy

    accepts_nested_attributes_for :menu_items, reject_if: :all_blank,
                                               allow_destroy: true

    default_scope { order(position: :asc) }

    scope :children, -> { where(parent_id: id) }

    protected

    def column_default
      self.method ||= Archangel::MENU_METHOD_DEFAULT
    end
  end
end
