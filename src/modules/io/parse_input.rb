def parse_input(input)
  # don't show anything with a '.'
  if input[0, 1] == '.' || input == ''

    # change channel
    if input[0, 3] == '.cc'
      temp = input[4, input.length].to_i
      if Bot::BOT.channel(temp).nil?
        puts 'Invalid channel'
      else
        $channel = temp
        puts "Channel is now #{$channel}"
        history = Bot::BOT.channel($channel).history(20)
        history.reverse_each { |message| parse_message(message) }
      end

    # change monitor
    elsif input[0, 3] == '.cm'
      temp = input[4, input.length].to_i
      if Bot::BOT.channel(temp).nil?
        puts 'Invalid channel'
      else
        $monitor = temp
        puts "Monitor channel is now #{$monitor}"
      end

    # Show history of monitored channel
    elsif input[0, 3] == '.hm'
      begin
        history = Bot::BOT.channel($monitor).history(20)
        history.reverse_each { |message| parse_message(message) }
      rescue StandardError => _error
        puts 'Cannot retrieve message history'
      end

    # Show history of monitored channel
    elsif input[0, 3] == '.hi'
      begin
        history = Bot::BOT.channel($channel).history(20)
        history.reverse_each { |message| parse_message(message) }
      rescue StandardError => _error
        puts 'Cannot retrieve message history'
      end

    # switch monitor and main channel
    elsif input[0, 3] == '.sw'
      temp = $monitor
      $monitor = $channel
      $channel = temp
      puts 'Channels swapped'

    # change monitor to last reply
    elsif input[0, 3] == '.mm'
      if $last_mention == 0
        puts 'You have no mentions this session'
      else
        $monitor = $last_mention
      end

    # reply to last mention
    elsif input[0, 3] == '.re'
      if $last_mention == 0
        puts 'You have no mentions this session'
      else
        Bot::BOT.send_message($last_mention, input[4, input.length])
      end

    # reply to monitor channel
    elsif input[0, 3] == '.rm'
      Bot::BOT.send_message($monitor, input[4, input.length])

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
        Bot::BOT.channel($channel).server.channels.each do |server|
          puts "#{server.name} | #{server.id}"
        end
      end

    end
  else
    Bot::BOT.send_message($channel, input)
  end
end
