def parse_input(input)
  # don't show anything with a '.'
  if input[0, 1] == '.' || input == ''

    # change Channel 1
    if input[0, 3] == '.c1'
      temp = input[4, input.length].to_i
      if Bot::BOT.channel(temp).nil?
        puts 'Invalid channel'
      else
        $channel1 = temp
        puts "Channel 1 is now #{$channel1}"
      end

    # change Channel 2
    elsif input[0, 3] == '.c2'
      temp = input[4, input.length].to_i
      if Bot::BOT.channel(temp).nil?
        puts 'Invalid channel'
      else
        $channel2 = temp
        puts "Channel 2 is now #{$channel2}"
      end

    # change channel 3
    elsif input[0, 3] == '.c3'
      temp = input[4, input.length].to_i
      if Bot::BOT.channel(temp).nil?
        puts 'Invalid channel'
      else
        $channel3 = temp
        puts "Channel 3 is now #{$channel3}"
      end

    # Show history of Channel 1
    elsif input[0, 3] == '.h1'
      begin
        history = Bot::BOT.channel($channel1).history(20)
        history.reverse_each { |message| parse_message(message) }
      rescue StandardError => error
        puts error
      end

    # Show history of Channel 2
    elsif input[0, 3] == '.h2'
      begin
        history = Bot::BOT.channel($channel2).history(20)
        history.reverse_each { |message| parse_message(message) }
      rescue StandardError => _error
        puts 'Cannot retrieve message history'
      end

    # Show history of Channel 3
    elsif input[0, 3] == '.h3'
      begin
        history = Bot::BOT.channel($channel3).history(20)
        history.reverse_each { |message| parse_message(message) }
      rescue StandardError => _error
        puts 'Cannot retrieve message history'
      end

    # switch Channel 1 and 2
    elsif input[0, 3] == '.12'
      temp = $channel2
      $channel2 = $channel1
      $channel1 = temp
      puts 'Channels swapped'

    # switch Channel 2 and 3
    elsif input[0, 3] == '.23'
      temp = $channel2
      $channel2 = $channel3
      $channel3 = temp
      puts 'Channels swapped'

    # switch Channel 1 and 3
    elsif input[0, 3] == '.13'
      temp = $channel3
      $channel3 = $channel1
      $channel1 = temp
      puts 'Channels swapped'

    # change channel 1 to last reply
    elsif input[0, 3] == '.1r'
      if $last_mention == 0
        puts 'You have no mentions this session'
      else
        $channel1 = $last_mention
      end

    # change channel 2 to last reply
    elsif input[0, 3] == '.2r'
      if $last_mention == 0
        puts 'You have no mentions this session'
      else
        $channel2 = $last_mention
      end

    # change channel 3 to last reply
    elsif input[0, 3] == '.3r'
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
        unless input.length < 5
          Bot::BOT.send_message($last_mention, input[4, input.length])
        end
      end

    # reply to Channel 2
    elsif input[0, 3] == '.r2'
      unless input.length < 5
        Bot::BOT.send_message($channel2, input[4, input.length])
      end

    # reply to Channel 3
    elsif input[0, 3] == '.r3'
      unless input.length < 5
        Bot::BOT.send_message($channel3, input[4, input.length])
      end

    # Eval code
    elsif input[0, 2] == '.e'
      begin
        puts eval input[3, input.length]
      rescue StandardError => error
        puts error
      end

    # List Servers
    elsif input[0, 3] == '.ls'
      Bot::BOT.servers.keys.each do |key|
        puts "#{Bot::BOT.server(key).name} | #{Bot::BOT.server(key).id}"
      end

    # List Channels
    elsif input[0, 3] == '.lc'
      if input.length > 3
        Bot::BOT.server(input[4, input.length]).channels.each do |server|
          puts "#{server.name} | #{server.id}"
        end
      else
        Bot::BOT.channel($channel1).server.channels.each do |server|
          puts "#{server.name} | #{server.id}"
        end
      end

    end
  else
    Bot::BOT.send_message($channel1, input)
  end
end
