# frozen_string_literal: true

require './discord/management/status'
require './discord/management/logging'

# functions to handle various discord events
module ManagementFunctions
  include Status
  include Logging
  extend Discordrb::EventContainer

  # Detect when bot is online and ready
  ready do |event|
    Status.activate(event)
    # Logging.startup(event)
  end
end
