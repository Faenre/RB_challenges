class Series
  def initialize(series)
    @series = series
    @digits = series.chars.map(&:to_i).to_a
  end

  def slices(size)
    raise ArgumentError if size > @digits.size

    @digits.each_cons(size).to_a
  end
end
