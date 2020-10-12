class Trinary
  VALIDATOR = /^[0-7]*$/

  attr_reader :orig_num

  def initialize(orig, base=3)
    @orig_num = orig
    @base = 3
  end

  def to_decimal
    decimal = 0
    return decimal unless valid?

    orig_num.chars.reverse.each_with_index do |digit, place|
      decimal += digit.to_i * (@base**place)
    end
    decimal
  end

  private

  def valid?
    orig_num =~ /^[0-#{@base}]*$/
  end
end
