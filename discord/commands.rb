# frozen_string_literal: true

require './discord/commands/broadcasts'
require './discord/commands/internal'
require './discord/commands/logchannel'
require './discord/commands/users'
require './discord/commands/test'

# Primary command container
module CommandHandler
  include Broadcasts
  include Internal
  include LogChannel
  include Users
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

  command(:users, help_available: false) do |event|
    Users.process(event)
  end

  command(:test, help_available: false) do |event|
    Test.process(event)
  end
end
