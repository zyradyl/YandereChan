# frozen_string_literal: true

# Laugh at Shi.
module LaughAtShi
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['laughatshi']\
    )
  end
end
