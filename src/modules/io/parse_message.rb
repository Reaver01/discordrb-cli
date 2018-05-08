def parse_message(message)
  time = message.timestamp.strftime('%I:%M%p')

  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".red}|#{message.channel.id}] "\
         "#{message.content.yellow}"

  # Channel 1 Messages
  elsif message.channel.id == $channel1
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".blue}] #{message.content.light_cyan}"

  # Channel 2 Messages
  elsif message.channel.id == $channel2
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".light_green}|"\
         "#{message.channel.id}] #{message.content.magenta}"

  # Channel 3 Messages
  elsif message.channel.id == $channel3
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".yellow}|"\
         "#{message.channel.id}] #{message.content.light_green}"

  # Direct Messages
  elsif message.channel.type == 1
    $last_mention = message.channel.id
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".red}|#{message.channel.id}] "\
         "#{message.content.green}"
  end
end
