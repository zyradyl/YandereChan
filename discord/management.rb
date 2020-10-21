require './discord/management/status'

module ManagementFunctions
  include Status
  extend Discordrb::EventContainer

  # Detect when bot is online and ready
  ready do |event|
    Status.activate(event)
  end

end
