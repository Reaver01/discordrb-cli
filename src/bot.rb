require 'bundler/setup'
require 'colorize'
require 'discordrb'
require 'discordrb/data'
require 'dotenv'
require 'time'

# This is the Bot
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

  colors = ['light_red', 'light_green', 'light_yellow', 'light_blue', 'light_magenta', 'light_cyan'].shuffle
  $color1 = colors[0 .. 1]
  $color2 = colors[2 .. 3]
  $color3 = colors[4 .. 5]
  $channel1 = ENV['CHANNEL1'].to_i
  $channel2 = ENV['CHANNEL2'].to_i
  $channel3 = ENV['CHANNEL3'].to_i
  $last_mention = 0

  Thread.new { BOT.run }

  input = String.new

  puts "Connected to:\n"\
       "#{"[Channel 1]".colorize(:"#{$color1[0]}")} #{"#{BOT.channel($channel1).server.name} / "\
       "#{BOT.channel($channel1).name}".colorize(:"#{$color1[1]}")}\n"\
       "#{"[Channel 2]".colorize(:"#{$color2[0]}")} #{"#{BOT.channel($channel2).server.name} / "\
       "#{BOT.channel($channel2).name}".colorize(:"#{$color2[1]}")}\n"\
       "#{"[Channel 3]".colorize(:"#{$color3[0]}")} #{"#{BOT.channel($channel3).server.name} / "\
       "#{BOT.channel($channel3).name}".colorize(:"#{$color3[1]}")}"\

  while input != '.exit'
    input = gets.chomp
    input = input.gsub!('\n', "\n") if input.include? '\n'
    parse_input(input) unless input == '.exit'
  end
end
