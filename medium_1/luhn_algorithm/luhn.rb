class Luhn
  attr_reader :number

  def self.create(num)
    luhn = Luhn.new(num * 10)
    num * 10 + luhn.checkdigit
  end

  def initialize(num)
    @number = num
  end

  def valid?
    (checksum % 10).zero?
  end

  def checksum
    addends.sum
  end

  def checkdigit
    valid? ? 0 : 10 - (checksum % 10)
  end

  def addends
    @number.digits.map.with_index do |digit, idx|
      digit = idx.even? ? digit : digit * 2
      digit -= 9 if digit > 9
      digit
    end.reverse
  end
end
