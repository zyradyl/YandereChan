require './discord/management/status'
require './discord/management/logging'

module ManagementFunctions
  include Status
  include Logging
  extend Discordrb::EventContainer

  # Detect when bot is online and ready
  ready do |event|
    Status.activate(event)
    #Logging.startup(event)
  end

end
