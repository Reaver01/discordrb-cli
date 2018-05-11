module Bot
  extend Bot
  def parse_input(input)
    # don't show anything with a '.'
    if input[0, 1] == '.' || input == ''

      # change Channel 1
      if input[0, 3] == '.c1'
        temp = input[4, input.length].to_i
        if BOT.channel(temp)
          $channel1 = temp
          puts "Channel 1 is now #{$channel1}"
        else
          puts 'Invalid channel'
        end

      # change Channel 2
      elsif input[0, 3] == '.c2'
        temp = input[4, input.length].to_i
        if BOT.channel(temp)
          $channel2 = temp
          puts "Channel 2 is now #{$channel2}"
        else
          puts 'Invalid channel'
        end

      # change channel 3
      elsif input[0, 3] == '.c3'
        temp = input[4, input.length].to_i
        if BOT.channel(temp)
          $channel3 = temp
        else
          puts "Channel 3 is now #{$channel3}"
          puts 'Invalid channel'
        end

      # Show history of Channel 1
      elsif input == '.h1'
        begin
          history = BOT.channel($channel1).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 2
      elsif input == '.h2'
        begin
          history = BOT.channel($channel2).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # Show history of Channel 3
      elsif input == '.h3'
        begin
          history = BOT.channel($channel3).history(20)
          history.reverse_each { |message| parse_message(message) }
        rescue StandardError => error
          puts error
        end

      # switch Channel 1 and 2
      elsif input == '.12'
        temp = $channel2
        $channel2 = $channel1
        $channel1 = temp
        temp = $color2
        $color2 = $color1
        $color1 = temp
        puts 'Channels swapped'

      # switch Channel 2 and 3
      elsif input == '.23'
        temp = $channel2
        $channel2 = $channel3
        $channel3 = temp
        temp = $color2
        $color2 = $color3
        $color3 = temp
        puts 'Channels swapped'

      # switch Channel 1 and 3
      elsif input == '.13'
        temp = $channel3
        $channel3 = $channel1
        $channel1 = temp
        temp = $color3
        $color3 = $color1
        $color1 = temp
        puts 'Channels swapped'

      # change channel 1 to last reply
      elsif input == '.1r'
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel1 = $last_mention
        end

      # change channel 2 to last reply
      elsif input == '.2r'
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel2 = $last_mention
        end

      # change channel 3 to last reply
      elsif input == '.3r'
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          $channel3 = $last_mention
        end

      # reply to last mention
      elsif input[0, 3] == '.re'
        if $last_mention == 0
          puts 'You have no mentions this session'
        else
          BOT.send_message($last_mention, input[4, input.length]) unless input.length < 5
        end

      # reply to Channel 2
      elsif input[0, 3] == '.r2'
        BOT.send_message($channel2, input[4, input.length]) unless input.length < 5

      # reply to Channel 3
      elsif input[0, 3] == '.r3'
        BOT.send_message($channel3, input[4, input.length]) unless input.length < 5

      # Eval code
      elsif input[0, 2] == '.e'
        begin
          puts eval input[3, input.length]
        rescue StandardError => error
          puts error
        end

      # List Servers
      elsif input == '.ls'
        BOT.servers.keys.each do |key|
          puts "#{BOT.server(key).name} | #{BOT.server(key).id}"
        end

      # List Channels
      elsif input[0, 3] == '.lc'
        if input.length > 3
          BOT.server(input[4, input.length]).channels.each do |server|
            puts "#{server.name} | #{server.id}"
          end
        else
          BOT.channel($channel1).server.channels.each do |server|
            puts "#{server.name} | #{server.id}"
          end
        end

      elsif input == '.tableflip'
        BOT.send_message($channel1, '(╯°□°）╯︵ ┻━┻')

      elsif input == '.tableflip2'
        BOT.send_message($channel2, '(╯°□°）╯︵ ┻━┻')

      elsif input == '.tableflip3'
        BOT.send_message($channel3, '(╯°□°）╯︵ ┻━┻')

      elsif input == '.shrug'
        BOT.send_message($channel1, '¯\_(ツ)_/¯')

      elsif input == '.shrug2'
        BOT.send_message($channel2, '¯\_(ツ)_/¯')

      elsif input == '.shrug3'
        BOT.send_message($channel3, '¯\_(ツ)_/¯')

      else
        puts 'Invalid input'
      end
    else
      BOT.send_message($channel1, input)
    end
  end
end