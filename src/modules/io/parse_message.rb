module Bot
  extend Bot
  def parse_message(message)
    
    color = Array.new
    color = if message.mentions.include? BOT.user(ENV['OWNER'].to_i)
            ['green', 'red']
          elsif message.channel.id == CHANNELS[0]
            [COLORS[0][0], COLORS[0][1]]
          elsif message.channel.id == CHANNELS[1]
            [COLORS[1][0], COLORS[1][1]]
          elsif message.channel.id == CHANNELS[2]
            [COLORS[2][0], COLORS[2][1]]
          elsif message.channel.type == 1
            ['red', 'green']
          end

    CHANNELS[3] = message.channel.id if message.mentions.include? BOT.user(ENV['OWNER'].to_i) || message.channel.type == 1

    # display messages
    if color.any?
      begin
        puts "[#{message.timestamp.strftime('%I:%M%p')}][<@#{message.user.id}>][#{message.channel.id}][@#{message.user.name}##{message.user.tag}]".colorize(:"#{color[0]}")
        puts message.content.colorize(:"#{color[1]}")
        puts message.attachments.first.proxy_url if message.attachments.first
      rescue error
        puts error
      end
    end
  end
end