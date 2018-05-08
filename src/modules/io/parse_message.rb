def parse_message(message)
  time = message.timestamp.strftime('%I:%M%p')

  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".red
    puts message.content.yellow
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?

  # Channel 1 Messages
  elsif message.channel.id == $channel1
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".light_magenta
    puts message.content.light_cyan
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?

  # Channel 2 Messages
  elsif message.channel.id == $channel2
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".light_green
    puts message.content.magenta
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?

  # Channel 3 Messages
  elsif message.channel.id == $channel3
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".yellow
    puts message.content.light_red
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?

  # Direct Messages
  elsif message.channel.type == 1
    $last_mention = message.channel.id
    puts "[#{time}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".red
    puts message.content.green
    puts message.attachments.first.proxy_url unless message.attachments.first.nil?
  end
end
