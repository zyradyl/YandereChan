# frozen_string_literal: true

# Utility to easily check permissions with one function
module CheckPermissions
  def self.process(event)
    senpais = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/senpais.txt")
    rivals = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/rivals.txt")

    return 0 if event.user.id == CONFIG['bot']['senpai']
    return 1 if senpais.include?("#{event.user.id}\n")
    return 2 if rivals.include?("#{event.user.id}\n")

    401
  end
end
