require './discord/commands/hello'
require './discord/commands/initialize'
require './discord/commands/laughatshi'
require './discord/commands/logchannel'
require './discord/commands/servers'
require './discord/commands/shutdown'
require './discord/commands/teststartup'

module CommandHandler
  include HelloWorld
  include Initialize
  include LaughAtShi
  include LogChannel
  include Shutdown
  include TestStartup
  extend Discordrb::Commands::CommandContainer

  command(:hello, help_available: false) do |event|
    HelloWorld.process(event)
  end

  command(:initialize, help_available: false) do |event|
    Initialize.process(event)
  end

  command(:laughatshi, help_available: false) do |event|
    LaughAtShi.process(event)
  end

  command(:logchannel, help_available: false) do |event|
    LogChannel.process(event)
  end

  command(:servers, help_available: false) do |event|
    Servers.process(event)
  end

  command(:shutdown, help_available: false) do |event|
    Shutdown.process(event)
  end

  command(:teststartup, help_available: false) do |event|
    TestStartup.process(event)
  end

end
