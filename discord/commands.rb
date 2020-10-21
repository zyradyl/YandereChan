require './discord/commands/hello'
require './discord/commands/laughatshi'
require './discord/commands/servers'
require './discord/commands/shutdown'

module CommandHandler
  include HelloWorld
  include LaughAtShi
  include Shutdown
  extend Discordrb::Commands::CommandContainer

  command(:hello, help_available: false) do |event|
    HelloWorld.process(event)
  end

  command(:laughatshi, help_available: false) do |event|
    LaughAtShi.process(event)
  end

  command(:servers, help_available: false) do |event|
    Servers.process(event)
  end

  command(:shutdown, help_available: false) do |event|
    Shutdown.process(event)
  end

end
