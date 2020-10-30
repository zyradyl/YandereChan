# frozen_string_literal: true

require './discord/commands/broadcast/create'
require './discord/commands/broadcast/destroy'

# Container to handle all commands pertaining to Broadcasts (custom embeds)
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
