# frozen_string_literal: true

require './discord/utilities/checkpermissions'

# Test the startup message in a way that isn't obnoxious.
module TestStartup
  include CheckPermissions

  def self.process(event)
    return unless CheckPermissions.process(event) <= 1

    storage = CONFIG['bot']['storage']

    Dir.each_child(storage).each do |d|
      file = "#{CONFIG['bot']['storage']}#{d}/logchannel.txt"
      logchannel = File.read(file)
      message(logchannel)
    end
  end

  def self.message(channel)
    embed = Discordrb::Webhooks::Embed.new
    embed.title = "YandereChan #{CONFIG['bot']['version']} Online"
    embed.colour = 0xf5b3bc
    embed.description = 'Online and ready to receive commands.'
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://media1.tenor.com/images/b9545b78bd1af4028d48ef694b8a095b/tenor.gif?itemid=15542747')
    YANDERE.send_message(channel, '', false, embed)
  end
end
