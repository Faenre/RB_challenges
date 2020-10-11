class School
  def initialize
    @roster = {}
  end

  def add(name, grade)
    roster[grade] ||= []

    roster[grade] << name
    roster[grade].sort!
  end

  def grade(g)
    roster[g] || []
  end

  def to_h
    roster.sort.map do |grade, names|
      [grade, names.sort]
    end.to_h
  end

  private

  attr_reader :roster
end
