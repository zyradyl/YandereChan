require './discord/commands/broadcast/create'

module Broadcasts
  include BroadcastCreate

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'create'
      BroadcastCreate.process(event)
    end

  end
end
