module Bot
  module Events
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        puts 'BOT Ready!'
      end
    end
  end
end
