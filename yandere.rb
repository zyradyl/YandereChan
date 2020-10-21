require 'rubygems'
require 'discordrb'
#require 'IO'
require 'json'
require 'securerandom'
require 'yaml'
require 'yaml/store'
require './discord/commands'
require './discord/management'

# Load configuration file into a constant
CONFIG = YAML.load_file('config.yaml')

# Establish DiscordRB Connection
YANDERE = Discordrb::Commands::CommandBot.new               \
  token:      CONFIG['apis']['discord']['secret_token'],  \
  client_id:  CONFIG['apis']['discord']['client_id'],     \
  prefix:     'yandere ', parse_self: true, advanced_functionality: true

# Extend Yandere functionality
YANDERE.include! CommandHandler
YANDERE.include! ManagementFunctions

# Activate Bot Connection
YANDERE.run
