require './discord/management/logging/startup'

module Logging
  include StartupMessage

  def self.startup(event)
    StartupMessage.send(event)
  end

end
