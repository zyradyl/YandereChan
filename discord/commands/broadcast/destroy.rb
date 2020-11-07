# frozen_string_literal: true

require './discord/utilities/checkpermissions'

# Allows organized deletion of broadcasts, including removal from database.
module BroadcastDestroy
  include CheckPermissions

  def self.process(event, message)
    return unless CheckPermissions.process(event) <= 1

    directory = "#{CONFIG['bot']['storage']}#{event.server.id}/broadcasts/"
    file = "#{directory}#{message}.yaml"
    fbroadcast = YAML.load_file(file)
    channel = YANDERE.channel(fbroadcast['channel'], event.server.id)
    broadcast = channel.load_message(message)

    broadcast.delete
    File.delete(file)
    YANDERE.send_message(event.channel.id, 'Hai, I have eliminated the target, s-senpai.')
  end
end
