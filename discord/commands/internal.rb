require './discord/commands/internal/initialize'
require './discord/commands/internal/servers'
require './discord/commands/internal/shutdown'

module Internal
  include Initialize
  include Servers
  include Shutdown

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'initialize'
      Initialize.process(event)
    when 'laughatshi'
      LaughAtShi.process(event)
    when 'servers'
      Servers.process(event)
    when 'shutdown'
      Shutdown.process(event)
    end
  end
end
