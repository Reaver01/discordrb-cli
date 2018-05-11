module Bot
  module Events
    # The Message Module
    module Message
      extend Discordrb::EventContainer
      message do |event|
        Bot.parse_message(event.message)
      end
    end
  end
end
