# frozen_string_literal: true

module Archangel
  # ApplicationRecord
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
