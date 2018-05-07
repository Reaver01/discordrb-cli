module Bot
  module Events
    module Message
      extend Discordrb::EventContainer
      message do |event|
        parse_message(event.message)
      end
    end
  end
end
