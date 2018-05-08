def parse_message(message)
  time = message.timestamp.strftime('%I:%M%p')
  display = false

  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    info = 'red'
    message = 'yellow'
    display = true

  # Channel 1 Messages
  elsif message.channel.id == $channel1
    info = 'light_yellow'
    text = 'light_cyan'
    display = true

  # Channel 2 Messages
  elsif message.channel.id == $channel2
    info = 'light_green'
    text = 'light_magenta'
    display = true

  # Channel 3 Messages
  elsif message.channel.id == $channel3
    info = 'yellow'
    text = 'light_red'
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
