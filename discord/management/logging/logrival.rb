# frozen_string_literal: true

# Output a notification when a new rival is added.
module LogRival
  def self.send(event)
    file = "#{CONFIG['bot']['storage']}/#{event.server.id}/logchannel.txt"
    logchannel = File.read(file)
    message(event, logchannel)
  end

  def self.message(event, logchannel)
    embed = Discordrb::Webhooks::Embed.new
    senpai = "<@#{CONFIG['bot']['senpai']}>"
    rivals = event.message.mentions

    embed.title = 'Rivals Added'
    embed.colour = 0xf5b3bc
    embed.description = 'Senpai has added rivals. These users now have access to administrative commands.'
    embed.timestamp = Time.at(event.timestamp)
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: 'https://media1.tenor.com/images/82a8b54bfa4bcc3e1209f50caf4b5835/tenor.gif?itemid=15762850')
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'YandereChan v0.0.1', icon_url: YANDERE.profile.avatar_url)
    embed.add_field(name: 'Senpai ID', value: senpai)
    embed.add_field(name: 'Channel', value: event.channel.mention)

    rivals.each do |rival|
      embed.add_field(name: 'Rival ID', value: rival.mention, inline: true)
    end

    YANDERE.send_message(logchannel, '', false, embed)
  end
end
