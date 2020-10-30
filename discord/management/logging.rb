# frozen_string_literal: true

require './discord/management/logging/logrival'
require './discord/management/logging/startup'

# Container module for Logging functions
module Logging
  include LogRival
  include StartupMessage

  def self.logrival(event)
    LogRival.send(event)
  end

  def self.startup(event)
    StartupMessage.send(event)
  end
end
