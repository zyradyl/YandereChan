# frozen_string_literal: true

require './discord/commands/rivals/add'

# Container for all commands pertaining to user privileges.
module Rivals
  include RivalsAdd

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'add'
      RivalsAdd.process(event)
    end
  end
end
