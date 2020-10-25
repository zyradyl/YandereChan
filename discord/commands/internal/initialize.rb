module Initialize

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id
    server_storage = CONFIG['bot']['storage'] + event.server.id.to_s
    if !Dir.exist?(server_storage)
      Dir.mkdir(server_storage)
    end
    if !Dir.exist?(server_storage + '/reaction_roles')
      Dir.mkdir(server_storage + '/reaction_roles')
    end
    if !Dir.exist?(server_storage + '/broadcasts')
      Dir.mkdir(server_storage + '/broadcasts')
    end
    if !Dir.exist?(server_storage + '/users')
      Dir.mkdir(server_storage + '/users')
    end
    YANDERE.send_message(event.channel.id, "On disk flatfile database created.")
  end

end
