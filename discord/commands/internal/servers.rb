# frozen_string_literal: true

# Print all servers YandereChan is in to the terminal she's running on.
module Servers
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    puts YANDERE.servers
  end
end
