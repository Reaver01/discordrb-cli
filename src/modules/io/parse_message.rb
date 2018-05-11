module Bot
  extend Bot
  def parse_message(message)

    # Mentions
    if message.mentions.include? BOT.user(ENV['OWNER'].to_i)
      CHANNELS[3] = message.channel.id
      info = 'green'
      text = 'red'
      display = true

    # Channel 1 Messages
    elsif message.channel.id == CHANNELS[0]
      info = COLORS[0][0]
      text = COLORS[0][1]
      display = true

    # Channel 2 Messages
    elsif message.channel.id == CHANNELS[1]
      info = COLORS[1][0]
      text = COLORS[1][1]
      display = true

    # Channel 3 Messages
    elsif message.channel.id == CHANNELS[2]
      info = COLORS[2][0]
      text = COLORS[2][1]
      display = true

    # Direct Messages
    elsif message.channel.type == 1
      CHANNELS[3] = message.channel.id
      info = 'red'
      text = 'green'
      display = true
    else

      display = false
    end

    # display messages
    if display
      begin
        puts "[#{message.timestamp.strftime('%I:%M%p')}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".colorize(:"#{info}")
        puts message.content.colorize(:"#{text}")
        puts message.attachments.first.proxy_url if message.attachments.first
      rescue error
        puts error
      end
    end
  end
end