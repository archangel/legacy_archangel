module Archangel
  class NullObject
    def to_a
      []
    end

    def to_ary
      []
    end

    def to_s
      ""
    end

    def to_f
      0.0
    end

    def to_i
      0
    end

    def nil?
      true
    end

    def present?
      false
    end

    def empty?
      true
    end

    def inspect
      format("#<%s:0x%x>", self.class, object_id)
    end

    def respond_to?(_message, _include_private = false)
      false
    end

    def method_missing(*_args, &_block)
      self
    end
  end
end
