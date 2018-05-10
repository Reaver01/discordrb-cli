def parse_message(message)

  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    info = 'green'
    text = 'red'
    display = true

  # Channel 1 Messages
  elsif message.channel.id == $channel1
    info = $colors[0]
    text = $colors[1]
    display = true

  # Channel 2 Messages
  elsif message.channel.id == $channel2
    info = $colors[2]
    text = $colors[3]
    display = true

  # Channel 3 Messages
  elsif message.channel.id == $channel3
    info = $colors[4]
    text = $colors[5]
    display = true

  # Direct Messages
  elsif message.channel.type == 1
    $last_mention = message.channel.id
    info = 'red'
    text = 'green'
    display = true
  else

    display = false
  end
  
  # display messages
  if display
    puts "[#{message.timestamp.strftime('%I:%M%p')}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".colorize(:"#{info}")
    puts message.content.colorize(:"#{text}")
    puts message.attachments.first.proxy_url if message.attachments.first
  end
end
