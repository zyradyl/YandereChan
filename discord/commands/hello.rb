module HelloWorld
  include ChatUtils

  def self.cmd_hello(event)
    YANDERE.send_message( \
      event.channel.id, \
      CONFIG['messages']['commands']['hello_world']\
    )
  end
  
end
