require './discord/management/logging'

module RivalsAdd
  include Logging

  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id
    users = event.message.mentions
    directory = CONFIG['bot']['storage'] + event.server.id.to_s + '/users/'
    file = directory + 'rivals.txt'

    users.each do |user|
      write = user.id.to_s + "\n"
      pass = user.id.to_s
      File.open(file, "a"){ |f| f.write(write) }
    end

    Logging.logrival(event)
  end
end
