module BroadcastCreate

  def self.process(event)
    creation_step = 0
    channel       = 0
    embed         = Discordrb::Webhooks::Embed.new
    embed.footer  = Discordrb::Webhooks::EmbedFooter.new( \
      text: 'YandereChan' + CONFIG['bot']['version'],     \
      icon_url: YANDERE.profile.avatar_url                \
    )

    event.user.await(:broadcast) do |broadcast_event|

      if broadcast_event.message.content.to_s == 'cancel'
        broadcast_event.respond 'you win!'
      else
        case creation_step
        when 0
          channel = broadcast_event.message.content.to_i
          YANDERE.send_message(                                                   \
            broadcast_event.channel.id,                                           \
            "Hai, I will post the completed message in " + channel.to_s + "\n" +  \
            "\n" +                                                                \
            "What should the title of the broadcast be?\n"                        \
          )
          creation_step = 1
          false
        when 1
          embed.title = broadcast_event.message.content.to_s
          YANDERE.send_message(                                     \
            broadcast_event.channel.id,                             \
            "Hai, your title is now set to " + embed.title + "\n" + \
            "\n" +                                                  \
            "What should the description of the broadcast be?\n"    \
          )
          creation_step = 2
          false
        when 2
          embed.description = broadcast_event.message.content.to_s
          YANDERE.send_message(                                         \
            broadcast_event.channel.id,                                 \
            "Hai, the description is now " + embed.description + "\n" + \
            "\n" +                                                      \
            "What should the color of the broadcast be?\n"              \
          )
          creation_step = 3
          false
        when 3
          embed.colour = 0xFF0000
          YANDERE.send_message(                                           \
            broadcast_event.channel.id,                                   \
            "Hai, the color is going to be " + embed.colour.to_s + "\n" + \
            "\n" +                                                        \
            "send any message to complete.\n"                             \
          )
          broadcast_event.respond 'making menu.... (ignoring ur color)'
          YANDERE.send_message(channel, "", false, embed)
          true
        end
      end
    end

    # This is the prompt for the broadcast creation process
    YANDERE.send_message(                                                                                           \
      event.channel.id,                                                                                             \
      "Hai, initializing broadcast creation. If you get bored of me at any time you can type `cancel` to stop.\n" + \
      "\n" +                                                                                                        \
      "What channel would you like the broadcast to be posted in?\n" +                                              \
      "***Note:*** *For the initial version of this command, please only use the Channel ID.*"                      \
    )
  end
end
