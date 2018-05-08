def parse_message(message)
  time = message.timestamp.strftime('%I:%M%p')
  display = false

  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    info = 'green'
    message = 'red'
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
  end
  
  # display messages
  if display
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".colorize(:"#{info}")
    puts message.content.colorize(:"#{text}")
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?
  end
end
