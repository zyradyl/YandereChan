# frozen_string_literal: true

require './discord/commands/test/hello'
require './discord/commands/test/startup'

# Container for all test commands.
module Test
  include HelloWorld
  include TestStartup

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'helloworld'
      HelloWorld.process(event)
    when 'startup'
      TestStartup.process(event)
    end
  end
end
