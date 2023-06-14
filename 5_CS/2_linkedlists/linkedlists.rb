class LinkedList
  attr_reader :tail
  attr_reader :head

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
        @new_head.next_node = @head.next_node
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
    return nil if index.negative? || @head.nil?

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
      break if at(@index).next_node == nil

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

    @string_output = ""

    @array_of_values.each do |value|
      value = 'nil' if value == nil
      @string_output.concat("( #{value} ) -> ")
    end

    @string_output.concat('nil')

    @string_output
  end

  def insert_at(value, index)
    @previous_node = at(index - 1)
    @next_node = at(index)
    @new_node = Node.new(value)

    @previous_node.next_node = @new_node unless index.zero?
    @head = @new_node if index.zero?

    @new_node.next_node = @next_node unless @next_node == nil
  end

  def remove_at(index)
    if index.zero?
      @head = @head.next_node
    elsif at(index).nil?
      return
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
end

class Node
  attr_accessor :next_node
  attr_accessor :value

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

list = LinkedList.new(1, 2, 3, 4, 5)
p list.to_s
p list.head
p list.tail
p list.size

p list.at(3)
p list.pop
p list.pop
p list.pop
p list.size
p list.to_s
p list.contains?(1)
p list.contains?(2)
p list.contains?(3)
p list.find(1)
# list.insert_at(6, 0)
puts list.to_s
# list.insert_at(6, 6)
puts list.to_s
list.remove_at(6)
p list.to_s
p list.find(5)
p list.pop
puts list.to_s
list.append(1)
puts list.to_s
list.append(2)
puts list.to_s
list.remove_at(0)
list.remove_at(0)
puts list.to_s