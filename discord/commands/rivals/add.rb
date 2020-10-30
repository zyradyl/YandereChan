# frozen_string_literal: true

require './discord/management/logging'

# This allows Senpai to add new members to the rival group in a server.
module RivalsAdd
  include Logging

  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    users = event.message.mentions
    directory = "#{CONFIG['bot']['storage']}#{event.server.id}/users/"
    file = "#{directory}rivals.txt"

    users.each do |user|
      write = "#{user.id}\n"
      pass = user.id.to_s
      File.open(file, 'a') { |f| f.write(write) }
    end

    Logging.logrival(event)
  end
end
