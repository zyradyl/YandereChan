module BroadcastCreate

  def self.process(event)

    YANDERE.send_message(event.channel.id, 'welcome to the super quick broadcast test system, start praying')
    YANDERE.send_message(event.channel.id, 'give me the title of the embed')

    event.user.await(:title) do |title_event|
      title = title_event.message.content.to_s
      YANDERE.send_message(event.channel.id, "title set to " + title)
      YANDERE.send_message(event.channel.id, "set the description")
      if title.empty?
        return false
      else
        return true
      end
    end

    event.user.await(:desc) do |desc_event|
      if title.empty?
        return false
      end
      desc = desc_event.message.content.to_s
      YANDERE.send_message(event.channel.id, "desc set to " + desc)
      YANDERE.send_message(event.channel.id, "set the color bar")
    end

    event.user.await(:color) do |color_event|
      color = color_event.message.content.to_s
      YANDERE.send_message(event.channel.id, "color set to " + color)
      YANDERE.send_message(event.channel.id, "where do you want it to go")
    end

    event.user.await(:chan) do |chan_event|
      chan = chan_event.message.content.to_i
      YANDERE.send_message(event.channel.id, 'chan set to <#' + chan + '>')
      YANDERE.send_message(event.channel.id, "keep praying")
    end

    embed = Discordrb::Webhooks::Embed.new
    embed.title = title
    embed.colour = '0x' + color
    embed.description = desc
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "YandereChan v0.0.1", icon_url: YANDERE.profile.avatar_url)

    YANDERE.send_message(chan, "", false, embed)

  end

end
