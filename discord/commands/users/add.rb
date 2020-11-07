# frozen_string_literal: true
# Refactoring Passes: 1

require './discord/management/logging'
require './discord/utilities/checkpermissions'

# This allows Senpai to add new members to the rival group in a server.
module UsersAdd
  include CheckPermissions
  include Logging

  def self.add_kouhai(event)
    event.user.await(:answer) do |answer_event|
      case answer_event.message.content.to_s.downcase
      when 'yes'
        send_embed(answer_event, kouhai_response_yes)
        answer_event.respond('**COMMAND ERROR:** Unknown Error.')
        true
      when 'no'
        send_embed(answer_event, kouhai_response_no)
        answer_event.respond('**COMMAND ABORTED.**')
        true
      else
        if answer_event.channel.id == event.channel.id
          YANDERE.send_message(answer_event.channel.id, CONFIG['logging']['users']['add']['kouhai']['error'])
        else
          YANDERE.send_message(answer_event.channel.id, CONFIG['logging']['users']['add']['kouhai']['avoid'])
        end
        false
      end
    end
    send_embed(event, kouhai_embed)
  end

  def self.add_rival(event)
    file = "#{CONFIG['bot']['storage']}#{event.server.id}/users/rivals.txt"
    adds = check_dups(event)
    return if adds.empty?

    adds.each do |user|
      File.open(file, 'a') { |f| f.write("#{user.id}\n") }
    end
    Logging.users(event, 'add', 'rival')
    event.respond(CONFIG['messages']['commands']['users']['add']['rival'])
  end

  def self.add_senpai(event)
    file = "#{CONFIG['bot']['storage']}#{event.server.id}/users/senpais.txt"
    adds = check_dups(event)
    return if adds.empty?

    adds.each do |user|
      File.open(file, 'a') { |f| f.write("#{user.id}\n") }
    end
    Logging.users(event, 'add', 'senpai')
    event.respond(CONFIG['messages']['commands']['users']['add']['senpai'])
  end

  def self.check_dups(event)
    rivals = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/rivals.txt")
    senpais = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/senpais.txt")
    users = event.message.mentions
    users.each do |user|
      if rivals.include?("#{user.id}\n")
        event.respond("<@#{user.id}> #{CONFIG['messages']['commands']['users']['add']['dup_rival']}")
        users.delete(user)
      elsif senpais.include?("#{user.id}\n")
        event.respond("<@#{user.id}> #{CONFIG['messages']['commands']['users']['add']['dup_senpai']}")
        users.delete(user)
      end
    end
    users
  end

  def self.kouhai_embed
    embed = kouhai_response
    embed.title = CONFIG['logging']['users']['add']['kouhai']['title']
    embed.description = CONFIG['logging']['users']['add']['kouhai']['desc']
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: CONFIG['logging']['users']['add']['kouhai']['image'])
    embed
  end

  def self.kouhai_response
    embed = Discordrb::Webhooks::Embed.new
    embed.footer = Discordrb::Webhooks::EmbedFooter.new( \
      text: "YandereChan #{CONFIG['bot']['version']}",      \
      icon_url: YANDERE.profile.avatar_url                  \
    )
    embed.colour = CONFIG['logging']['general']['color']
    embed
  end

  def self.kouhai_response_no
    embed = kouhai_response
    embed.title = CONFIG['logging']['users']['add']['kouhai']['no']['title']
    embed.description = CONFIG['logging']['users']['add']['kouhai']['no']['desc']
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: CONFIG['logging']['users']['add']['kouhai']['no']['image']
    )
    embed
  end

  def self.kouhai_response_yes
    embed = kouhai_response
    embed.title = CONFIG['logging']['users']['add']['kouhai']['yes']['title']
    embed.description = CONFIG['logging']['users']['add']['kouhai']['yes']['desc']
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: CONFIG['logging']['users']['add']['kouhai']['yes']['image']
    )
    embed
  end

  def self.process(event, rank)
    return unless CheckPermissions.process(event) <= 1

    case rank
    when 'senpai'
      add_senpai(event)
    when 'rival'
      add_rival(event)
    when 'kouhai'
      add_kouhai(event)
    end
  end

  def self.send_embed(event, embed)
    YANDERE.send_message(
      event.channel.id,
      '',
      false,
      embed
    )
  end
end
