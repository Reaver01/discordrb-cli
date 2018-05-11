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

  BOT = Discordrb::Commands::CommandBot.new help_available: false,
                                            help_command: false,
                                            parse_self: true,
                                            prefix: PREFIX,
                                            token: ENV['TOKEN'],
                                            type: :user

  Dir['src/modules/events/*.rb'].each { |mod| load mod }
  Events.constants.each { |mod| BOT.include! Events.const_get mod }

  Dir['src/modules/io/*.rb'].each { |file| load file }

  Discordrb::LOGGER.streams = [NullLogger.new]

  col = ['light_red', 'light_green', 'light_yellow', 'light_blue', 'light_magenta', 'light_cyan'].shuffle
  COLORS = [col[0 .. 1], col[2 .. 3], col[4 .. 5]]
  CHANNELS = [ENV['CHANNEL1'].to_i, ENV['CHANNEL2'].to_i, ENV['CHANNEL3'].to_i, 0]

  Thread.new { BOT.run }

  input = String.new

  puts "Connected to:\n"\
       "#{"[Channel 1]".colorize(:"#{COLORS[0][0]}")} #{"#{BOT.channel(CHANNELS[0]).server.name} / "\
       "#{BOT.channel(CHANNELS[0]).name}".colorize(:"#{COLORS[0][1]}")}\n"\
       "#{"[Channel 2]".colorize(:"#{COLORS[1][0]}")} #{"#{BOT.channel(CHANNELS[1]).server.name} / "\
       "#{BOT.channel(CHANNELS[1]).name}".colorize(:"#{COLORS[1][1]}")}\n"\
       "#{"[Channel 3]".colorize(:"#{COLORS[2][0]}")} #{"#{BOT.channel(CHANNELS[2]).server.name} / "\
       "#{BOT.channel(CHANNELS[2]).name}".colorize(:"#{COLORS[2][1]}")}"\

  while input != '.exit'
    input = gets.chomp
    input = input.gsub!('\n', "\n") if input.include? '\n'
    parse_input(input) unless input == "#{PREFIX}exit"
  end
end
