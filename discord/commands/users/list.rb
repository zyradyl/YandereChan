# frozen_string_literal: true

require './discord/management/logging'
require './discord/utilities/checkpermissions'

# This lists the various privileged users
module UsersList
  include CheckPermissions
  include Logging

  def self.process(event, rank)
    return unless CheckPermissions.process(event) <= 1

    case rank.downcase
    when 'all', 'everyone'
      list_senpais(event)
      list_rivals(event)
    when 'senpai', 'senpais'
      list_senpais(event)
    when 'rival', 'rivals'
      list_rivals(event)
    end
  end

  def self.list_senpais(event)
    senpais = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/senpais.txt")
    slist = Discordrb::Webhooks::Embed.new
    slist.footer = Discordrb::Webhooks::EmbedFooter.new( \
      text: "YandereChan #{CONFIG['bot']['version']}",     \
      icon_url: YANDERE.profile.avatar_url                \
    )
    slist.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new( \
      url: 'https://media1.tenor.com/images/be4a63a9c7bc780a09244f863f3cb8e0/tenor.gif?itemid=4928092' \
    )
    slist.title = 'Senpai Server Directory'
    slist.description = 'E-eto..eto..these are all my S-Senpais...d-daisuke~'
    slist.colour = 0xf5b3bc
    slist.add_field(name: "Global Senpai", value: "<@#{CONFIG['bot']['senpai']}>")
    senpais.each do |senpai|
      slist.add_field(name: "Local Senpai", value: "<@#{senpai.delete("\n")}>", inline: true)
    end
    YANDERE.send_message(event.channel.id, '', false, slist)
  end

  def self.list_rivals(event)
    rivals = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/rivals.txt")
    rlist = Discordrb::Webhooks::Embed.new
    rlist.footer = Discordrb::Webhooks::EmbedFooter.new( \
      text: "YandereChan #{CONFIG['bot']['version']}",     \
      icon_url: YANDERE.profile.avatar_url                \
    )
    rlist.title = 'Rival Server Directory'
    rlist.colour = 0xf5b3bc
    if rivals.empty?
      rlist.description = "There's no one else that competes for my Senpais' attention! You weren't thinking of...noticing...anyone else.. were you?"
      rlist.image = Discordrb::Webhooks::EmbedImage.new( \
        url: 'https://media1.tenor.com/images/2bd6209e96136722cf7ce562fdd870bf/tenor.gif?itemid=14772012'\
      )
    else
      rlist.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new( \
        url: 'https://media1.tenor.com/images/82a8b54bfa4bcc3e1209f50caf4b5835/tenor.gif?itemid=15762850' \
      )
      rlist.description = "These are all the...the...the...~~fucking maggots~~FRIENDS that my S-Senpais...h-have.."
      rivals.each do |rival|
        rlist.add_field(name: "Rival", value: "<@#{rival.delete("\n")}>", inline: true)
      end
    end
    YANDERE.send_message(event.channel.id, '', false, rlist)
  end
end
