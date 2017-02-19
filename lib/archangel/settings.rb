# frozen_string_literal: true

module Archangel
  # Application setting
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Settings
    extend Forwardable

    attr_reader :hash

    def_delegators :hash, :key?, :[], :[]=, :to_hash, :to_json, :inspect

    def initialize(hash = {})
      @hash = if hash.respond_to?(:with_indifferent_access)
                hash.with_indifferent_access
              else
                hash
              end
    end

    def add(key, value = nil)
      hash[key.to_sym] = value.is_a?(Hash) ? Settings.new(value) : value
    end

    protected

    def method_missing(method_name, *_args, &_block)
      if method_name.to_s[-1] == "?"
        key?(method_name.to_s.sub("?", ""))
      elsif key?(method_name)
        value = hash[method_name]

        value.is_a?(Hash) ? Settings.new(value) : value
      else
        default_value
      end
    end

    def default_value
      nil
    end
  end
end
