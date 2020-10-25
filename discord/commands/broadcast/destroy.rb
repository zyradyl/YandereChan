module BroadcastDestroy
  def self.process(event, message)
    directory = CONFIG['bot']['storage'] + event.server.id.to_s + '/broadcasts/'
    file = directory + message.to_s + '.yaml'
    fbroadcast = YAML.load_file(file)

    # we need to use the pure API to do the little bit of magic we need.
    response = Discordrb::API::Channel.resolve(              \
      CONFIG['apis']['discord']['secret_token'],  \
      fbroadcast['channel']                       \
    )
    channel = Discordrb::Channel.new(JSON.parse(response), self, event.server.id)

    broadcast = channel.load_message(message)
    broadcast.delete
    YANDERE.send_message(event.channel.id, 'if this giant block of magic worked there should be a deleted message.')
  end
end
