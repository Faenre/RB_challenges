
class CircularBuffer
  class BufferEmptyException < Exception
  end

  class BufferFullException < Exception
  end

  attr_reader :buffer

  def initialize(size)
    @buffer = (0...size).map { BufferItem.new }
  end

  def read
    raise BufferEmptyException if empty?

    oldest.read
  end

  def write(obj)
    raise BufferFullException if full?

    find_available_slot.write obj
  end

  def write!(obj)
    full? ? oldest.write(obj) : write(obj)
  end

  def clear
    buffer.each { |slot| slot.read }
    nil
  end

  private

  def empty?
    buffer.all?(&:empty?)
  end

  def full?
    buffer.none?(&:empty?)
  end

  def find_available_slot
    buffer.each { |b| return b if b.empty? }
  end

  def sorted_nonempty
    buffer.reject(&:empty?).sort
  end

  def newest
    sorted_nonempty.last
  end

  def oldest
    sorted_nonempty.first
  end
end

class BufferItem
  def write(obj)
    return if obj.nil?

    @item = obj
    @timestamp = Time.now
  end

  def read
    temp_item = @item
    @item = nil
    @timestamp = nil
    temp_item
  end

  def empty?
    !@item
  end

  def <=>(other)
    yield ArgumentError unless other.is_a? BufferItem

    # return 0 unless timestamp || other.timestamp
    # return +1 if timestamp && !other.timestamp
    # return -1 if !timestamp && other.timestamp

    @timestamp <=> other.timestamp
  end

  protected

  attr_reader :item, :timestamp
end
