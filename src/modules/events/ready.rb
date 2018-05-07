module Bot
  module Events
    # The Ready Module
    module Ready
      extend Discordrb::EventContainer
      ready do |_event|
        puts 'BOT Ready!'
      end
    end
  end
end
