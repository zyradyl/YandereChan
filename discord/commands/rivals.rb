require './discord/commands/rivals/add'

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
