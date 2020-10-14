class CircularBuffer
  class BufferEmptyException < Exception
  end

  class BufferFullException < Exception
  end

  def initialize(size)
    @buffer = []
    @max_size = size
  end

  def read
    raise BufferEmptyException if empty?

    @buffer.shift
  end

  def write(obj)
    raise BufferFullException if full?

    write! obj
  end

  def write!(obj)
    return if obj.nil?

    @buffer.shift if full?
    @buffer << obj
  end

  def clear
    @buffer = []
  end

  private

  def full?
    @buffer.size == @max_size
  end

  def empty?
    @buffer.empty?
  end
end
