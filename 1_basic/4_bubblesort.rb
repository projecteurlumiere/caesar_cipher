def bubble_sort(array)
  array.length.times do
    array.each_with_index do | element, i |
      if i + 1 == array.length { return }
      elsif element > array[i+1]
        temp = element
        array[i] = array[i+1]
        array[i+1] = temp 
      end
    end
  end
  array
end

bubble_sort([4,3,78,2,0,2])