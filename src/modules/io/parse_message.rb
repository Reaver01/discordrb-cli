def parse_message(message)
  
  time = message.timestamp.strftime("%I:%M%p")
  
  # Mentions
  if message.mentions.include? Bot::BOT.user(ENV['OWNER'].to_i)
    $last_mention = message.channel.id
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".red}|#{message.channel.id}] #{message.content.yellow}"      

  # Regular messages
  elsif message.channel.id == $channel
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".blue}] #{message.content}"

  # Direct Messages
  elsif message.channel.type == 1
    $last_mention = message.channel.id
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".red}|#{message.channel.id}] #{message.content.green}"

  # Montioring channel
  elsif message.channel.id == $monitor
    puts "[#{time}][#{"@#{message.user.name}##{message.user.tag}".light_green}|#{message.channel.id}] #{message.content.magenta}"
  end
end
