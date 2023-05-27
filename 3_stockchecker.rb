def stock_picker(array)
  all_pairs = Array.new(0)
  array.each_with_index do | element, i |
    ((array.length - 1) - i).times do 
    pair = Array.new(0)
    pair << element
    pair << array[i+1]
    pair << pair[1] - pair[0]
    all_pairs << pair
    i += 1
    end
  end 
  profits = Array.new(0)
  all_pairs.each do | pair |
    profits << pair[2]
  end
  result = all_pairs[profits.index(profits.max)]
  puts "buy for #{result[0]} and sell for #{result[1]} to get a profit of #{result[2]}"
end

stock_picker([17,3,6,9,15,8,6,1,10])

