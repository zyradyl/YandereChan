require './discord/commands/test/hello'

module Test
  include HelloWorld

  def self.process(event)
    command = event.content.strip.split(' ')

    case command[2]
    when 'helloworld'
      HelloWorld.process(event)
    end
  end
end
