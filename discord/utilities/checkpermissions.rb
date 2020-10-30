# frozen_string_literal: true

# Utility to easily check permissions with one function
module CheckPermissions
  def self.process(event)
    return 1 if event.user.id == CONFIG['bot']['senpai']

    directory = "#{CONFIG['bot']['storage']}/#{event.server.id}/users/"
    rivalsf = "#{directory}rivals.txt"
    rivals = File.readlines(rivalsf)

    return 1 if rivals.include?("#{event.user.id}\n")

    0
  end
end
