require './discord/commands/broadcast/create'
require './discord/commands/broadcast/destroy'

module Broadcasts
  include BroadcastCreate
  include BroadcastDestroy

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'create'
      BroadcastCreate.process(event)
    when 'destroy'
      BroadcastDestroy.process(event, command[3])
    end
  end
end
