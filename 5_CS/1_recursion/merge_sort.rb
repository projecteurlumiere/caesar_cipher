class Array
  def merge_sort
    if self.length == 1
      self
    else
      second_half = self.pop(self.length / 2)
      first_half = self

      first_half = first_half.merge_sort
      second_half = second_half.merge_sort

      compare_and_merge_two_sorted_arrays(first_half, second_half)
    end
  end

  private

  def compare_and_merge_two_sorted_arrays(first_array, second_array)
    new_array = []

    # way better than the previous nested loops version:
    while !first_array.empty? && !second_array.empty? do
      if first_array[0] >= second_array[0]
        new_array << second_array[0]
        second_array.shift
      elsif first_array[0] < second_array[0]
        new_array << first_array[0]
        first_array.shift
      end
    end

    if first_array.empty?
      new_array += second_array
    elsif second_array.empty?
      new_array += first_array
    end
    new_array
  end
end

a = [3,2,1,6,8,7,5,4]
p a.merge_sort
