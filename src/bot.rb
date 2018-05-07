require 'bundler/setup'
require 'colorize'
require 'discordrb'
require 'discordrb/data'
require 'dotenv'
require 'time'

module Bot
  
  PREFIX = '.'.freeze
  
  Dotenv.load
  
  BOT = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'],
                                            prefix: PREFIX,
                                            advanced_functionality: false,
                                            ignore_bots: false,
                                            type: :user,
                                            help_command: false,
                                            parse_self: true,
                                            help_available: false,
                                            debug: false
  
  BOT.set_user_permission(ENV['OWNER'].to_i, 1)
  
  Dir['src/modules/events/*.rb'].each { |mod| load mod }
  Events.constants.each { |mod| BOT.include! Events.const_get mod }
  
  Dir['src/modules/io/*.rb'].each { |file| load file }
  
  Discordrb::LOGGER.streams = [NullLogger.new]
  
  $channel = ENV['CHANNEL1']
  $monitor = ENV['CHANNEL2']
  $last_mention = 0
  
  Thread.new { BOT.run }
  
  input = ''
  
  while input != '.exit' do
    input = gets.chomp
    parse_input(input) unless input == '.exit'
  end
end