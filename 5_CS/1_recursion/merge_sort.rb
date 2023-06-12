class Array
  def merge_sort
    if self.length <= 1
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
    first_array_length = first_array.length
    second_array_length = second_array.length

    i_first = 0
    i_second = 0

    while i_first < first_array_length && i_second < second_array_length do
      if first_array[i_first] >= second_array[i_second]
        new_array << second_array[i_second]
        i_second += 1
      elsif first_array[i_first] < second_array[i_second]
        new_array << first_array[i_first]
        i_first += 1
      end
    end

    if i_first == first_array_length
      addendum = second_array.pop(second_array_length - i_second)
      new_array += addendum
    elsif i_second == second_array_length
      addendum = first_array.pop(first_array_length - i_first)
      new_array += addendum
    end

    new_array
  end
end
