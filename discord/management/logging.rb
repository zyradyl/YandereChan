# frozen_string_literal: true

require './discord/management/logging/users'
require './discord/management/logging/startup'

# Container module for Logging functions
module Logging
  include UserLogging
  include StartupMessage

  def self.users(event, function, task)
    UserLogging.log(event, function, task)
  end

  def self.logrival(event)
    LogRival.send(event)
  end

  def self.startup(event)
    StartupMessage.send(event)
  end
end
