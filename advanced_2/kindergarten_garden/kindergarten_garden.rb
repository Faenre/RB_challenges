class Garden
  DEFAULT_STUDENTS = %w(Alice Bob Charlie David Eve Fred Ginny
                        Harriet Ileana Joseph Kincaid Larry).freeze

  def initialize(diagram, student_names=DEFAULT_STUDENTS)
    @names = student_names.map(&:downcase).sort
    @students = @names.map { |name| [name.to_sym, Student.new(name)] }.to_h
    @diagram = diagram

    define_student_methods
    allocate_diagram(diagram)
  end

  private

  def define_student_methods
    @students.each do |name, student|
      define_singleton_method(name) { student.plants }
    end
  end

  def allocate_diagram
    rows = @diagram.split("\n").map(&:chars)

    @students.each do |_, garden|
      rows.each { |row| garden << row.shift(2) }
    end
  end
end

class Student
  PLANTS = { 'C' => :clover, 'G' => :grass,
             'R' => :radishes, 'V' => :violets }.freeze

  attr_accessor :plants

  def initialize
    @plants = []
  end

  def <<(arr)
    @plants += arr.map { |p| PLANTS[p] }
  end
end
