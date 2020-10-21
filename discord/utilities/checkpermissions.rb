module CheckPermissions

  def self.process(event)
    if event.user.id == CONFIG['bot']['senpai']['identifier']
      return 1
    end

    directory = CONFIG['bot']['storage'] + '/' + event.server.id.to_s + '/users/'
    rivalsf = directory + 'rivals.txt'
    rivals = File.readlines(rivalsf)

    if rivals.include?(event.user.id.to_s + "\n")
        return 1
    end

    return 0
  end

end
