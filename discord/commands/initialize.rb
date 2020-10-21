module Initialize

  def self.process(event)
    return unless CONFIG['bot']['senpai']['identifier'] == event.user.id
    server_storage = CONFIG['bot']['storage'] + event.server.id.to_s
    Dir.mkdir(server_storage)
    Dir.mkdir(server_storage + '/reaction_roles')
    Dir.mkdir(server_storage + '/users')
    YANDERE.send_message(event.channel.id, "You should have directories now.")
  end

end
