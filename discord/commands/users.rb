# frozen_string_literal: true

require './discord/commands/users/add'
require './discord/commands/users/list'
require './discord/commands/users/remove'

# Container for all commands pertaining to user privileges.
module Users
  include UsersAdd
  include UsersList
  include UsersRemove

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'add'
      UsersAdd.process(event, command[3])
    when 'remove'
      UsersRemove.process(event)
    when 'list'
      UsersList.process(event, command[3])
    end
  end
end
