# NullLogger will divert discordrb's logger to the nether
class NullLogger
  def puts(_); end

  def flush; end
end
