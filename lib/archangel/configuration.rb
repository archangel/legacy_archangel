require "forwardable"

module Archangel
  class Configuration
    extend Forwardable

    attr_reader :hash

    def_delegators :hash, :key?, :[], :[]=, :to_hash, :to_json, :inspect

    def initialize(hash)
      @hash = if hash.respond_to?(:with_indifferent_access)
        hash.with_indifferent_access
      else
        hash
      end
    end

    def add(key, value = nil)
      hash[key.to_sym] = value.kind_of?(Hash) ? Configuration.new(value) : value
    end

    protected

    def method_missing(method_name, *args, &block)
      if method_name.to_s[-1] == "?"
        key?(normalized_key(method_name.to_s[0..-2]))
      else
        if key?(method_name)
          value = hash[method_name]

          value.kind_of?(Hash) ? Configuration.new(value) : value
        else
          # TODO: Notify when key not loaded?
          default_value
        end
      end
    end

    def default_value
      nil
    end
  end
end
