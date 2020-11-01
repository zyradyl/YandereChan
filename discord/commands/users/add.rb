# frozen_string_literal: true

require './discord/management/logging'
require './discord/utilities/checkpermissions'

# This allows Senpai to add new members to the rival group in a server.
module UsersAdd
  include CheckPermissions
  include Logging

  def self.process(event, rank)
    return unless CheckPermissions.process(event) <= 1

    case rank
    when 'senpai'
      add_senpai(event)
    when 'rival'
      add_rival(event)
    when 'kouhai'
      add_kouhai(event)
    else
      error(event)
    end
  end

  def self.add_senpai(event)
    users = event.message.mentions
    file = "#{CONFIG['bot']['storage']}#{event.server.id}/users/senpais.txt"

    users.each do |user|
      File.open(file, 'a') { |f| f.write("#{user.id}\n") }
    end
    Logging.users(event, 'add', 'senpai')
  end

  def self.add_rival(event)
    users = event.message.mentions
    file = "#{CONFIG['bot']['storage']}#{event.server.id}/users/rivals.txt"

    users.each do |user|
      File.open(file, 'a') { |f| f.write("#{user.id}\n") }
    end
    Logging.users(event, 'add', 'rival')
  end

  def self.kouhai_embed
    embed = Discordrb::Webhooks::Embed.new
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "YandereChan #{CONFIG['bot']['version']}",
      icon_url: YANDERE.profile.avatar_url
    )
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: 'https://media1.tenor.com/images/2624ae5fa81f58c494ea861b77af4b42/tenor.gif?itemid=13451196'
    )
    embed.colour = CONFIG['logging']['general']['color']
    embed.title = CONFIG['logging']['users']['add']['kouhai']['title']
    embed.description = CONFIG['logging']['users']['add']['kouhai']['desc']
    embed
  end

  def self.add_kouhai(event)
    embed = kouhai_embed()

    event.user.await(:answer) do |answer_event|
      response = Discordrb::Webhooks::Embed.new
      response.footer = Discordrb::Webhooks::EmbedFooter.new( \
        text: "YandereChan #{CONFIG['bot']['version']}",      \
        icon_url: YANDERE.profile.avatar_url                  \
      )
      response.colour = 0xf5b3bc

      case answer_event.message.content.to_s.downcase
      when 'yes'
        response.title = 'NO!'
        response.description = "I won't let you!"
        response.image = Discordrb::Webhooks::EmbedImage.new(
          url: 'https://media1.tenor.com/images/12c7210c22ee281fb3c54279d5a023df/tenor.gif?itemid=16465192'
        )
        YANDERE.send_message(answer_event.channel.id, '', false, response)
        answer_event.respond('**COMMAND ERROR:** Unknown Error.')
        true
      when 'no'
        response.title = "I didn't think so~"
        response.description = "Of course you wouldn't do that to me, "       \
                               'S-Senpai. Haha, I must have... I must have '  \
                               "misunderstood... I'll cancel that command now."
        response.image = Discordrb::Webhooks::EmbedImage.new(
          url: 'https://media1.tenor.com/images/44e8fa985d5cf6795d23e5aaf5da7951/tenor.gif?itemid=17411593'
        )
        YANDERE.send_message(answer_event.channel.id, '', false, response)
        answer_event.respond('**COMMAND ABORTED.**')
        true
      else
        if answer_event.channel.id == event.channel.id
          YANDERE.send_message(
            answer_event.channel.id,
            'I asked you a question, Senpai. Yes or no? I can wait all day.'
          )
        else
          YANDERE.send_message(
            answer_event.channel.id,
            "You can't run away from me, Senpai. Answer me. Yes or no?"
          )
        end
        false
      end
    end

    YANDERE.send_message(event.channel.id, '', false, embed)
  end

  def self.error(event); end
end
