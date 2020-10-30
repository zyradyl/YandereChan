# frozen_string_literal: true

require './discord/commands/broadcasts'
require './discord/commands/internal'
require './discord/commands/logchannel'
require './discord/commands/rivals'
require './discord/commands/test'

# Primary command container
module CommandHandler
  include Broadcasts
  include Internal
  include LogChannel
  include Rivals
  include Test
  extend Discordrb::Commands::CommandContainer

  command(:broadcast, help_available: false) do |event|
    Broadcasts.process(event)
  end

  command(:internal, help_available: false) do |event|
    Internal.process(event)
  end

  command(:logchannel, help_available: false) do |event|
    LogChannel.process(event)
  end

  command(:rivals, help_available: false) do |event|
    Rivals.process(event)
  end

  command(:test, help_available: false) do |event|
    Test.process(event)
  end
end
