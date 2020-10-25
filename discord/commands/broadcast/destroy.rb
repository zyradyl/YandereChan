module BroadcastDestroy
  def self.process(event, message)
    directory = CONFIG['bot']['storage'] + event.server.id.to_s + '/broadcasts/'
    file = directory + message.to_s + '.yaml'
    fbroadcast = YAML.load_file(file)
    channel = YANDERE.channel(fbroadcast['channel'], event.server.id)
    broadcast = channel.load_message(message)
    broadcast.delete
    File.delete(file)
    YANDERE.send_message(event.channel.id, 'Hai, I have eliminated the target, s-senpai.')
  end
end
