require './discord/commands/test/hello'
require './discord/commands/test/laughatshi'


module Test
  include HelloWorld
  include LaughAtShi

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'helloworld'
      HelloWorld.process(event)
    when 'laughatshi'
      LaughAtShi.process(event)
    end

  end
end
