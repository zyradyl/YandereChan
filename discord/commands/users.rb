# frozen_string_literal: true

require './discord/commands/users/add'

# Container for all commands pertaining to user privileges.
module Users
  include UsersAdd

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'add'
      UsersAdd.process(event, command[3])
    end
  end
end
