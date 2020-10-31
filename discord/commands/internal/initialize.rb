# frozen_string_literal: true

# This module allows for the creation of the flatfile database for individual
# servers. Eventually this should be done automatically when YandereChan is
# invited to servers, but this also allows for a way to update the on-disk
# data store if an update is ever made.
module Initialize
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    server_storage = CONFIG['bot']['storage'] + event.server.id.to_s
    Dir.mkdir(server_storage) unless Dir.exist?(server_storage)
    Dir.mkdir("#{server_storage}/reaction_roles") unless Dir.exist?("#{server_storage}/reaction_roles")
    Dir.mkdir("#{server_storage}/broadcasts") unless Dir.exist?("#{server_storage}/broadcasts")
    Dir.mkdir("#{server_storage}/users") unless Dir.exist?("#{server_storage}/users")
    FileUtils.touch("#{server_storage}/users/senpais.txt") unless File.exist?("#{server_storage}/users/senpais.txt")
    FileUtils.touch("#{server_storage}/users/rivals.txt") unless File.exist?("#{server_storage}/users/rivals.txt")
    YANDERE.send_message(event.channel.id, 'On disk flatfile database created.')
  end
end
