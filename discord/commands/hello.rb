module HelloWorld

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'].include?(event.user.id)
    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['hello_world']\
    )
  end

end
