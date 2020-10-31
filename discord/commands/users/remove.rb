# frozen_string_literal: true

require './discord/management/logging'
require './discord/utilities/checkpermissions'

# This allows Senpai to add new members to the rival group in a server.
module UsersRemove
  include CheckPermissions
  include Logging

  def self.process(event)
    return unless CheckPermissions.process(event) <= 1

    users = event.message.mentions
    delete_senpai(event, users)
    delete_rival(event, users)
  end

  def self.delete_rival(event, users)
    rivals = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/rivals.txt")

    users.each do |user|
      next unless rivals.include?("#{user.id}\n")

      rivals.delete("#{user.id}\n")
      event.respond('rival delet')
    end

    File.open("#{CONFIG['bot']['storage']}/#{event.server.id}/users/rivals.txt", 'w') do |file|
      rivals.each do |rival|
        file.write rival
      end
    end
  end

  def self.delete_senpai(event, users)
    senpais = File.readlines("#{CONFIG['bot']['storage']}/#{event.server.id}/users/senpais.txt")

    users.each do |user|
      next unless senpais.include?("#{user.id}\n")

      senpais.delete("#{user.id}\n")
      event.respond('senpai delet')
    end

    File.open("#{CONFIG['bot']['storage']}/#{event.server.id}/users/senpais.txt", 'w') do |file|
      senpais.each do |senpai|
        file.write senpai
      end
    end
  end
end
