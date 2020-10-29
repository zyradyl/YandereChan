module Servers
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    puts YANDERE.servers
  end
end
