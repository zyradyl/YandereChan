require './discord/management/logging'

module AddRival
  include Logging

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id

    # this breaks the command into three sections, the user id should be
    # command[2]
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
