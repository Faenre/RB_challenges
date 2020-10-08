class PigLatin
  VOWEL_STARTS = %w(a e i o u yt xr).freeze

  MULTI_CHAR_STARTS = {
    3 => /^(thr|sch|[^aeuio]qu)/,
    2 => /^(ch|qu|th)/
  }.freeze

  def self.translate(phrase)
    words = phrase.split
    words.map { |word| new(word).to_pig }.join ' '
  end

  attr_accessor :word

  def initialize(word)
    @word = word
  end

  def to_pig
    starts_with_vowel? ? word + 'ay' : rotated + 'ay'
  end

  def starts_with_vowel?
    VOWEL_STARTS.any? { |vowel| word.start_with? vowel }
  end

  def rotated
    word.chars.rotate(rotate_size).join
  end

  private

  def rotate_size
    MULTI_CHAR_STARTS.each do |size, regexp|
      return size if word =~ regexp
    end
    1
  end
end
