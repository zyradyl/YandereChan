module Servers

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id
    puts YANDERE.servers
  end

end
