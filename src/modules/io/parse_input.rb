module Bot
  extend Bot
  def parse_input(input)
    if input.length > 0 && input.start_with?(PREFIX)
      input = input.split(" ")
      command = input[0]
      input.shift
      if input.any?
        args = input.join(" ")
        channel_id = args.to_i if args.match? /\A\d+\z/
      else
        args = String.new
        channel_id = 0
      end

      # change Channel 1
      if command == "#{PREFIX}c1"
        if BOT.channel(channel_id)
          CHANNELS[0] = channel_id
          puts "Channel 1 is now #{CHANNELS[0]}"
        else
          puts 'Invalid channel'
        end

      # change Channel 2
      elsif command == "#{PREFIX}c2"
        if BOT.channel(channel_id)
          CHANNELS[1] = channel_id
          puts "Channel 2 is now #{CHANNELS[1]}"
        else
          puts 'Invalid channel'
        end

      # change channel 3
      elsif command == "#{PREFIX}c3"
        if BOT.channel(channel_id)
          CHANNELS[2] = channel_id
          puts "Channel 3 is now #{CHANNELS[2]}"
        else
          puts 'Invalid channel'
        end

      # Show history of Channel 1
      elsif command == "#{PREFIX}h1"
        begin
          history = BOT.channel(CHANNELS[0]).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 2
      elsif command == "#{PREFIX}h2"
        begin
          history = BOT.channel(CHANNELS[1]).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 3
      elsif command == "#{PREFIX}h3"
        begin
          history = BOT.channel(CHANNELS[2]).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # switch Channel 1 and 2
      elsif command == "#{PREFIX}12"
        CHANNELS[0], CHANNELS[1] = CHANNELS[1], CHANNELS[0]
        COLORS[0], COLORS[1] = COLORS[1], COLORS[0]
        puts 'Channels swapped'

      # switch Channel 2 and 3
      elsif command == "#{PREFIX}23"
        CHANNELS[1], CHANNELS[2] = CHANNELS[2], CHANNELS[1]
        COLORS[1], COLORS[2] = COLORS[2], COLORS[1]
        puts 'Channels swapped'

      # switch Channel 1 and 3
      elsif command == "#{PREFIX}13"
        CHANNELS[0], CHANNELS[2] = CHANNELS[2], CHANNELS[0]
        COLORS[0], COLORS[2] = COLORS[2], COLORS[0]
        puts 'Channels swapped'

      # change channel 1 to last reply
      elsif command == "#{PREFIX}1r"
        if CHANNELS[3] == 0
          puts 'You have no mentions this session'
        else
          CHANNELS[0] = CHANNELS[3]
        end

      # change channel 2 to last reply
      elsif command == "#{PREFIX}2r"
        if CHANNELS[3] == 0
          puts 'You have no mentions this session'
        else
          CHANNELS[1] = CHANNELS[3]
        end

      # change channel 3 to last reply
      elsif command == "#{PREFIX}3r"
        if CHANNELS[3] == 0
          puts 'You have no mentions this session'
        else
          CHANNELS[2] = CHANNELS[3]
        end

      # reply to last mention
      elsif command == "#{PREFIX}re"
        if CHANNELS[3] == 0
          puts 'You have no mentions this session'
        else
          BOT.send_message(CHANNELS[3], args) if args.length > 0
        end

      # reply to Channel 2
      elsif command == "#{PREFIX}r2"
        BOT.send_message(CHANNELS[1], args) if args.length > 0

      # reply to Channel 3
      elsif command == "#{PREFIX}r3"
        BOT.send_message(CHANNELS[2], args) if args.length > 0

      # Eval code
      elsif command == "#{PREFIX}e"
        begin
          puts eval args
        rescue StandardError => error
          puts error
        end

      # List Servers
      elsif command == "#{PREFIX}ls"
        BOT.servers.keys.each do |key|
          puts "#{BOT.server(key).name} | #{BOT.server(key).id}"
        end

      # List Channels
      elsif command == "#{PREFIX}lc"
        if BOT.server(channel_id)
          BOT.server(channel_id).channels.each do |server|
            puts "#{server.name} | #{server.id}"
          end
        else
          BOT.channel(CHANNELS[0]).server.channels.each do |server|
            puts "#{server.name} | #{server.id}"
          end
        end

      elsif command == "#{PREFIX}tableflip"
        BOT.send_message(CHANNELS[0], '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}tableflip2"
        BOT.send_message(CHANNELS[1], '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}tableflip3"
        BOT.send_message(CHANNELS[2], '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}shrug"
        BOT.send_message(CHANNELS[0], '¯\_(ツ)_/¯')

      elsif command == "#{PREFIX}shrug2"
        BOT.send_message(CHANNELS[1], '¯\_(ツ)_/¯')

      elsif command == "#{PREFIX}shrug3"
        BOT.send_message(CHANNELS[2], '¯\_(ツ)_/¯')

      else
        puts 'Invalid input'
      end
    else
      BOT.send_message(CHANNELS[0], input)
    end
  end
end