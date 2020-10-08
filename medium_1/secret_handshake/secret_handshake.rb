class SecretHandshake
  COMMANDS = [
    "wink",
    "double blink",
    "close your eyes",
    "jump"
  ].freeze

  def initialize(secret)
    @secret = (secret.is_a?(String) ? secret : secret.to_s(2)).rjust(5, '0')
  end

  def commands
    list = secret.chars[1..-1].reverse.map.with_index do |key, idx|
      key == '1' ? COMMANDS[idx] : nil
    end
    list.select! { |s| s }
    secret[0] == '0' ? list : list.reverse
  end

  private

  attr_reader :secret
end
