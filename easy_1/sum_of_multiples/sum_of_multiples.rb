class SumOfMultiples
  DEFAULTS = [3, 5].freeze

  def self.to(limit)
    new(*DEFAULTS).to(limit)
  end

  def initialize(*multipliers)
    @multipliers = multipliers
  end

  def to(limit)
    @multipliers.map do |num|
      multiples(num, limit)
    end.flatten.uniq.sum
  end

  private

  def multiples(num, limit)
    arr = []
    n = 0
    arr << n while (n += num) < limit
    arr
  end
end
