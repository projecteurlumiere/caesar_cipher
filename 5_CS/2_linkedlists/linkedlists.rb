class LinkedList
  attr_reader :tail, :head

  def initialize(*values)
    if values.empty?
      @head = nil
      @tail = nil
    else
      set_new_list(*values)
    end
  end

  def append(*values)
    if @head.nil?
      set_new_list(*values)
    else
      values.each do |value|
        @new_tail = Node.new(value)
        @tail.next_node = @new_tail
        @tail = @new_tail
      end
    end
  end

  def prepend(*values)
    if @head.nil?
      set_new_list(*values.reverse)
    else
      values.each do |value|
        @new_head = Node.new(value)
        @new_head.next_node = @head
        @head = @new_head
      end
    end
  end

  def size
    return 0 if @head.nil?

    @size = 1
    @node = @head.next_node

    until @node.nil?
      @size += 1
      @node = @node.next_node
    end

    @size
  end

  def at(index)
    index = transform_negative_index(index) if index.negative?
    return nil if @head.nil?
    return nil unless index.between?(0, self.size - 1)

    return @head if index.zero?

    @node = @head.next_node
    @i = 1

    until index == @i || @node.nil?
      @node = @node.next_node
      @i += 1
    end

    @node
  end

  def pop
    if @head.nil?
      @popped_node_value = nil
    elsif @head == @tail
      @popped_node_value = @head.value
      @head = nil
      @tail = nil
    else
      @node = @head
      @node = @node.next_node until @node.next_node == @tail

      @popped_node_value = @tail.value
      @node.next_node = nil
      @tail = @node
    end

    @popped_node_value
  end

  def contains?(value)
    return false if @head.nil?

    @node = @head

    until @node.value == value
      return false if @node.next_node.nil?

      @node = @node.next_node
    end

    true
  end

  def find(value)
    return nil if @head.nil?

    @index = 0

    until value == at(@index).value
      break if at(@index).next_node.nil?

      @index += 1
    end

    return nil unless value == at(@index).value

    @index
  end

  def to_s
    @array_of_values = []
    @node = @head

    until @node.nil?
      @array_of_values << @node.value
      @node = @node.next_node
    end

    @string_output = ''

    @array_of_values.each do |value|
      value = 'nil' if value.nil?
      @string_output.concat("( #{value} ) -> ")
    end

    @string_output.concat('nil')

    @string_output
  end

  def insert_at(value, index)
    if index + 1 > @size
      append_and_insert_at(value, index, self.size)
    else
      just_insert_at(value, index, self.size)
    end
  end

  def remove_at(index)
    index = transform_negative_index(index) if index.negative?

    return unless index.between?(0, self.size - 1)

    if index.zero?
      @head = @head.next_node
    elsif at(index) == @tail
      @tail = at(index - 1)
      @tail.next_node = nil
    else
      at(index - 1).next_node = at(index + 1)
    end
  end

  private

  def set_new_list(*values)
    @head = Node.new(values[0])
    @tail = @head

    return if values.length <= 1

    values.shift
    values.each { |value| append(value) }
  end

  def append_and_insert_at(value, index, size)
    if @head.nil?
      set_new_list
      (index - size).times { append(nil) }
    else
      (index + 1 - size).times { append(nil) }
    end

    @tail.value = value
  end

  def just_insert_at(value, index, size)
    index = transform_negative_index(index)
    return if index > size

    @previous_node = at(index - 1)
    @next_node = at(index)
    @new_node = Node.new(value)

    @previous_node.next_node = @new_node unless index.zero?
    @head = @new_node if index.zero?

    @new_node.next_node = @next_node unless @next_node.nil?
  end

  def transform_negative_index(index)
    index = (self.size + index) if index.negative?
    index
  end

  class Node
    attr_accessor :next_node, :value

    def initialize(value)
      @value = value
      @next_node = nil
    end
  end
end
