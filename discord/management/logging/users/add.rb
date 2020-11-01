# frozen_string_literal: true

# handle logging for adding users
module AddUserLogging
  def self.basic_log(event)
    log = Discordrb::Webhooks::Embed.new
    log.colour = CONFIG['logging']['general']['color']
    log.timestamp = Time.at(event.timestamp)
    log.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "YandereChan #{CONFIG['bot']['version']}",
      icon_url: YANDERE.profile.avatar_url
    )
    log.add_field(name: 'Authorized User', value: event.user.mention)
    log.add_field(name: 'Channel', value: event.channel.mention)
    log
  end

  def self.custom_rival(event, log)
    log.title = CONFIG['logging']['users']['add']['rival']['title']
    log.description = CONFIG['logging']['users']['add']['rival']['desc']
    log.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
      url: CONFIG['logging']['users']['add']['rival']['thumbnail']
    )
    event.message.mentions.each do |rival|
      log.add_field(name: 'New Rival', value: "<@#{rival.id}>", inline: true)
    end
    log
  end

  def self.custom_senpai(event, log)
    log.title = CONFIG['logging']['users']['add']['senpai']['title']
    log.description = CONFIG['logging']['users']['add']['senpai']['desc']
    log.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
      url: CONFIG['logging']['users']['add']['senpai']['thumbnail']
    )
    event.message.mentions.each do |senpai|
      log.add_field(name: 'New Senpai', value: "<@#{senpai.id}>", inline: true)
    end
    log
  end

  def self.log_senpai(event)
    log = basic_log(event)
    log = custom_senpai(event, log)
    send(event, log)
  end

  def self.log_rival(event)
    log = basic_log(event)
    log = custom_rival(event, log)
    send(event, log)
  end

  def self.process(event, task)
    case task
    when 'senpai'
      log_senpai(event)
    when 'rival'
      log_rival(event)
    end
  end

  def self.send(event, log)
    YANDERE.send_message(
      File.read("#{CONFIG['bot']['storage']}/#{event.server.id}/logchannel.txt"),
      '',
      false,
      log
    )
  end
end
