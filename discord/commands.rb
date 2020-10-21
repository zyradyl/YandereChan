require './discord/commands/hello'

module CommandHandler
  include HelloWorld
  extend Discordrb::Commands::CommandContainer

  command :bot, help_available: false do |event|
    self.process(event)
  end

  def self.process(event)
    return unless CONFIG['special']['senpai']['identifier'].include?(event.user.id)
    command = event.content.strip.split(' ')
    case command[1]
    when 'hello'
      cmd_hello(event)
    end
  end
  
end
