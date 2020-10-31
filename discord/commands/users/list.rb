# frozen_string_literal: true

require './discord/management/logging'
require './discord/utilities/checkpermissions'

# This lists the various privileged users
module UsersList
  include CheckPermissions
  include Logging

  def self.process(event, rank)
    return unless CheckPermissions.process(event) <= 1

    case rank.downcase
    when 'senpai', 'senpais'
      list_senpais(event)
    when 'rival', 'rivals'
      list_rivals(event)
    end
  end

  def self.list_senpais(event)
    event.respond('senpais')
  end

  def self.list_rivals(event)
    event.respond('rivals')
  end
end
