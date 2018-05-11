module Bot
  extend Bot
  def parse_input(input)
    if input.length > 0 && input.start_with?(PREFIX)
      input = input.split(" ")
      command = input[0]
      input.shift
      args = String.new
      channel_id = 0
      if input.any?
        args = input.join(" ")
        channel_id = args.to_i if args.match? /\A\d+\z/
      end

      # change Channel 1
      if command == "#{PREFIX}c1"
        if BOT.channel(channel_id)
          $channel1 = channel_id
          puts "Channel 1 is now #{$channel1}"
        else
          puts 'Invalid channel'
        end

      # change Channel 2
      elsif command == "#{PREFIX}c2"
        if BOT.channel(channel_id)
          $channel2 = channel_id
          puts "Channel 2 is now #{$channel2}"
        else
          puts 'Invalid channel'
        end

      # change channel 3
      elsif command == "#{PREFIX}c3"
        if BOT.channel(channel_id)
          $channel3 = channel_id
          puts "Channel 3 is now #{$channel3}"
        else
          puts 'Invalid channel'
        end

      # Show history of Channel 1
      elsif command == "#{PREFIX}h1"
        begin
          history = BOT.channel($channel1).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 2
      elsif command == "#{PREFIX}h2"
        begin
          history = BOT.channel($channel2).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 3
      elsif command == "#{PREFIX}h3"
        begin
          history = BOT.channel($channel3).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # switch Channel 1 and 2
      elsif command == "#{PREFIX}12"
        $channel1, $channel2 = $channel2, $channel1
        $color1, $color2 = $color2, $color1
        puts 'Channels swapped'

      # switch Channel 2 and 3
      elsif command == "#{PREFIX}23"
        $channel2, $channel3 = $channel3, $channel2
        $color2, $color3 = $color3, $color2
        puts 'Channels swapped'

      # switch Channel 1 and 3
      elsif command == "#{PREFIX}13"
        $channel1, $channel3 = $channel3, $channel1
        $color1, $color3 = $color3, $color1
        puts 'Channels swapped'

      # change channel 1 to last reply
      elsif command == "#{PREFIX}1r"
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel1 = $last_mention
        end

      # change channel 2 to last reply
      elsif command == "#{PREFIX}2r"
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel2 = $last_mention
        end

      # change channel 3 to last reply
      elsif command == "#{PREFIX}3r"
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel3 = $last_mention
        end

      # reply to last mention
      elsif command == "#{PREFIX}re"
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          BOT.send_message($last_mention, args) if args.length > 0
        end

      # reply to Channel 2
      elsif command == "#{PREFIX}r2"
        BOT.send_message($channel2, args) if args.length > 0

      # reply to Channel 3
      elsif command == "#{PREFIX}r3"
        BOT.send_message($channel3, args) if args.length > 0

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
          BOT.channel($channel1).server.channels.each do |server|
            puts "#{server.name} | #{server.id}"
          end
        end

      elsif command == "#{PREFIX}tableflip"
        BOT.send_message($channel1, '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}tableflip2"
        BOT.send_message($channel2, '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}tableflip3"
        BOT.send_message($channel3, '(╯°□°）╯︵ ┻━┻')

      elsif command == "#{PREFIX}shrug"
        BOT.send_message($channel1, '¯\_(ツ)_/¯')

      elsif command == "#{PREFIX}shrug2"
        BOT.send_message($channel2, '¯\_(ツ)_/¯')

      elsif command == "#{PREFIX}shrug3"
        BOT.send_message($channel3, '¯\_(ツ)_/¯')

      else
        puts 'Invalid input'
      end
    else
      BOT.send_message($channel1, input)
    end
  end
end