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

    first_array.each_with_index do |first_array_element, first_array_element_index|

      second_array.each_with_index do |second_array_element, second_array_element_index|
        if second_array_element.nil?
          next
        elsif first_array_element >= second_array_element
          new_array << second_array_element
          second_array[second_array_element_index] = nil
        elsif first_array_element < second_array_element
          new_array << first_array_element
          first_array[first_array_element_index] = nil
          break
        end
      end

      if first_array.all?(nil)
        new_array = concatenate_the_rest(new_array, second_array)
        break
      elsif second_array.all?(nil)
        new_array = concatenate_the_rest(new_array, first_array)
        break
      end
    end
    new_array
  end

  def concatenate_the_rest(sorted_array, array_to_add)
    array_to_add.delete(nil)
    sorted_array + array_to_add
  end
end
