module Initialize
  def self.process(event)
    return unless CONFIG['bot']['senpai'] == event.user.id

    server_storage = CONFIG['bot']['storage'] + event.server.id.to_s
    Dir.mkdir(server_storage) unless Dir.exist?(server_storage)
    Dir.mkdir(server_storage + '/reaction_roles') unless Dir.exist?(server_storage + '/reaction_roles')
    Dir.mkdir(server_storage + '/broadcasts') unless Dir.exist?(server_storage + '/broadcasts')
    Dir.mkdir(server_storage + '/users') unless Dir.exist?(server_storage + '/users')
    YANDERE.send_message(event.channel.id, 'On disk flatfile database created.')
  end
end
