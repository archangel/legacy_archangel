# frozen_string_literal: true

module Archangel
  # Application mailer
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationMailer < ActionMailer::Base
    default from: "noreply@example.com"

    layout "mailer"
  end
end
