# frozen_string_literal: true

module Archangel
  class ApplicationMailer < ActionMailer::Base
    default from: "noreply@example.com"
    layout "mailer"
  end
end
