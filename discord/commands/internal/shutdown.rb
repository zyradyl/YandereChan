# frozen_string_literal: true

# Gracefully shutdown YandereChan, including disconnecting the Websocket.
module Shutdown
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['shutdown']\
    )
    YANDERE.stop
  end
end
