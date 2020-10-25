module Shutdown

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id
    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['shutdown']\
    )
    YANDERE.stop
  end

end
