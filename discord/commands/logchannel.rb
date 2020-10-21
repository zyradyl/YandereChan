module LogChannel

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id

    # this breaks the command into three sections, the channel id should be
    # command[2]
    command = event.content.strip.split(' ')
    file = CONFIG['bot']['storage'] + event.server.id.to_s + '/logchannel.txt'
    channel_name = '<#' + command[2].to_s + '>'
    message = CONFIG['messages']['commands']['logchannel'] + channel_name

    File.write(file, command[2])
    YANDERE.send_message( \
      event.channel.id,   \
      message             \
    )
  end

end
