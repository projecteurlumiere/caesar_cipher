class LinkedList
  attr_reader :tail
  attr_reader :head

  def initialize(*values)
    values.each do |value|
      if value == values[0]
        @head = append(value)
        @tail = @head
      else
        append(value)
      end
    end
  end

  def append(value)
    @new_tail = Node.new(value)
    @tail.next_node = @new_tail if @tail != nil
    @tail = @new_tail
  end

  def prepend(value)
    @new_head = Node.new(value)
    @new_head.next_node = @head.next_node
    @head = @new_head
  end

  def size
    return 0 if @head.nil?

    @size = 1
    @node = @head.next_node

    until @node == nil
      @size += 1
      @node = @node.next_node
    end

    @size
  end

  def at(index)
    return @head if index.zero?

    @node = @head.next_node
    i = 1

    until index == i
      @node = @node.next_node
      return nil if @node == nil

      i += 1
    end

    @node
  end

  def pop
    return nil if @head.nil?

    if @head == @tail
      @popped_node_value = @head.value
      @head = nil
      return @popped_node_value
    end

    @node = @head

    until @node.next_node == @tail
      @node = @node.next_node
    end

    @popped_node_value = @tail.value
    @node.next_node = nil
    @tail = @node

    @popped_node_value
  end

  def contains?(value)
    return false if @head.nil?

    @node = @head

    until @node.value == value
      return false if @node.next_node == nil
      @node = @node.next_node
    end

    true
  end

  def find(value)

    @index = 0
    until value == at(@index).value
      @index += 1
      break if at(@index).next_node == nil
    end

    return nil unless value == at(@index).value

    @index
  end

  def to_s
    @node = @head
    @array_of_values = []
    until @node == nil
      @array_of_values << @node.value
      @node = @node.next_node
    end

    @string_output = ""

    @array_of_values.each do |value|
      @string_output.concat("( #{value} ) -> ")
    end

    @string_output.concat("nil")

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
    if index == 0
      @head = @head.next_node
    elsif at(index) == nil
      return
    else
      at(index - 1).next_node = at(index + 1)
    end
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
# p list
# p list.head
# p list.tail
# p list.size

# p list.at(3)
# p list.pop
# p list.pop
# p list.pop
# p list.size
# p list
# p list.contains?(1)
# p list.contains?(2)
# p list.contains?(3)
# p list.find(1)
list.insert_at(6, 0)
puts list.to_s
list.insert_at(6, 6)
puts list.to_s
list.remove_at(6)
puts list.to_s
