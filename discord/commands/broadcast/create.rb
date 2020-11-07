# frozen_string_literal: true

require './discord/utilities/checkpermissions'

# Creation wizard for Broadcasts (custom embeds)
module BroadcastCreate
  include CheckPermissions

  def self.process(event)
    return unless CheckPermissions.process(event) <= 1

    creation_step = 0
    channel       = 0
    embed         = Discordrb::Webhooks::Embed.new

    embed.footer  = Discordrb::Webhooks::EmbedFooter.new( \
      text: "YandereChan #{CONFIG['bot']['version']}",     \
      icon_url: YANDERE.profile.avatar_url                \
    )

    event.user.await(:broadcast) do |broadcast_event|
      if broadcast_event.message.content.to_s == 'cancel'
        broadcast_event.respond 'aborting broadcast creation.'
      else
        case creation_step
        when 0
          channel = broadcast_event.message.content.to_i
          YANDERE.send_message(                                                   \
            broadcast_event.channel.id,                                           \
            "Hai, I will post the completed message in #{channel} \n" \
            "\n" \
            "What should the title of the broadcast be?\n"                        \
          )
          creation_step = 1
          false
        when 1
          embed.title = broadcast_event.message.content.to_s
          YANDERE.send_message(                                     \
            broadcast_event.channel.id,                             \
            "Hai, your title is now set to #{embed.title}\n" \
            "\n" \
            "What should the description of the broadcast be?\n"    \
          )
          creation_step = 2
          false
        when 2
          embed.description = broadcast_event.message.content.to_s
          YANDERE.send_message(                                         \
            broadcast_event.channel.id,                                 \
            "Hai, the description is now #{embed.description}\n" \
            "\n" \
            "What should the color of the broadcast be?\n" \
            '***Note:*** *For the initial version of this command, ' \
            'please use hex color codes without the #, ' \
            'so for example, red would be FF0000.*'                     \
          )
          creation_step = 3
          false
        when 3
          color = "0x#{broadcast_event.message.content}"
          embed.colour = color.hex
          YANDERE.send_message(                                           \
            broadcast_event.channel.id,                                   \
            "Hai, the color is going to be #{embed.colour}\n" \
            "\n" \
            "type done to complete your broadcast.\n"                     \
          )
          creation_step = 4
          false
        when 4
          broadcast_event.respond 'Creating new broadcast...'
          final = YANDERE.send_message(channel, '', false, embed)
          store(final, embed.title, embed.description, embed.color)
        end
      end
    end

    # This is the prompt for the broadcast creation process
    prompt(event)
  end

  def self.store(message, title, desc, color)
    directory = "#{CONFIG['bot']['storage']}#{message.channel.server.id}/broadcasts/"
    file = "#{directory}#{message.id}.yaml"
    broadcast = {}
    broadcast['channel'] = message.channel.id
    broadcast['title'] = title
    broadcast['description'] = desc
    broadcast['color'] = color
    File.open(file, 'w') { |f| YAML.dump(broadcast, f) }
  end

  def self.prompt(event)
    YANDERE.send_message(                                                                                           \
      event.channel.id,                                                                                             \
      "Hai, initializing broadcast creation. If you get bored of me at any time you can type `cancel` to stop.\n" \
      "\n" \
      "What channel would you like the broadcast to be posted in?\n" \
      '***Note:*** *For the initial version of this command, please only use the Channel ID.*'                      \
    )
  end
end
