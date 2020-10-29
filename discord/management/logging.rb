require './discord/management/logging/logrival'
require './discord/management/logging/startup'

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
