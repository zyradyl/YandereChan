module CheckPermissions
  def self.process(event)
    return 1 if event.user.id == CONFIG['bot']['senpai']['identifier']

    directory = CONFIG['bot']['storage'] + '/' + event.server.id.to_s + '/users/'
    rivalsf = directory + 'rivals.txt'
    rivals = File.readlines(rivalsf)

    return 1 if rivals.include?(event.user.id.to_s + "\n")

    0
  end
end
