# frozen_string_literal: true

# When it works, this will list all known broadcasts in the database.
module BroadcastList
  def self.process(event)
    directory = "#{CONFIG['bot']['storage']}#{event.server.id}/broadcasts/"
    embed = Discordrb::Webhooks::Embed.new
    embed.footer = Discordrb::Webhooks::EmbedFooter.new( \
      text: "YandereChan #{CONFIG['bot']['version']}",     \
      icon_url: YANDERE.profile.avatar_url                \
    )

    embed.title = 'Server Broadcast List'
    embed.description = 'Here is the list you asked for, S-Senpai~'
    embed.colour = 0xf5b3bc

    # Dir.each_child
  end
end
