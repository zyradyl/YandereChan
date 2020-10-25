require './discord/utilities/checkpermissions'

module HelloWorld
  include CheckPermissions

  def self.process(event)

    return unless CheckPermissions.process(event) == 1

    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['hello_world']\
    )
  end

end
