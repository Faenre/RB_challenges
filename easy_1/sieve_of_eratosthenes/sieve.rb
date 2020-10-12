class Sieve
  def initialize(limit)
    raise ArgumentError if limit < 2

    @limit = limit
  end

  def primes
    numbers = sieve_range

    primes = []

    numbers.each do |num, is_prime|
      next unless is_prime

      primes << num

      composite = num**2
      until composite > @limit
        numbers[composite] = false
        composite += num
      end
    end

    primes
  end

  private

  def sieve_range
    2.upto(@limit).map { |n| [n, true] }.to_h
  end
end
