# frozen_string_literal: true

require './discord/utilities/checkpermissions'

# Simple helloworld test to make sure most mechanics are still working after
# major changes to the command handling code.
module HelloWorld
  include CheckPermissions

  def self.process(event)
    return unless CheckPermissions.process(event) <= 1

    YANDERE.send_message( \
      event.channel.id,\
      CONFIG['messages']['commands']['hello_world']\
    )
  end
end
