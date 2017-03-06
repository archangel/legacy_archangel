# frozen_string_literal: true

require "i18n"
require "active_support/core_ext/array/extract_options"

module Archangel
  extend ActionView::Helpers::TranslationHelper

  class << self
    # Flash message type based on Bootstrap flash types
    #
    # = Example
    #   en:
    #     archangel:
    #       foo: Bar
    #       hello:
    #         word: Hello World
    #
    #   "<%= Archangel.translate('archangel.foo') %>" #=> "Bar"
    #   "<%= Archangel.translate(:foo) %>" #=> "Bar"
    #   "<%= Archangel.translate('foo') %>" #=> "Bar"
    #   "<%= Archangel.t('archangel.foo') %>" #=> "Bar"
    #   "<%= Archangel.t(:foo) %>" #=> "Bar"
    #   "<%= Archangel.t('foo') %>" #=> "Bar"
    #   "<%= Archangel.t('hello.world') %>" #=> "Hello World"
    #
    # @param [String, Symbol] args
    #                         translation argument
    # @return [String] translated string
    #
    def translate(*args)
      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:archangel)
      args << options

      super(*args)
    end
    alias t translate
  end
end
