# frozen_string_literal: true

require './discord/management/logging/users/add'
require './discord/management/logging/users/list'
require './discord/management/logging/users/remove'

# handle all logging for users
module UserLogging
  include AddUserLogging

  def self.log(event, function, task)
    case function
    when 'add'
      AddUserLogging.process(event, task)
    end
  end
end
