class Octal
  VALIDATOR = /^[0-7]*$/

  attr_reader :octal

  def initialize(octal)
    @octal = (octal =~ VALIDATOR ? octal : '0')
  end

  def to_decimal
    decimal = 0

    octal.chars.reverse.each_with_index do |digit, place|
      decimal += digit.to_i * (8**place)
    end
    decimal
  end
end
