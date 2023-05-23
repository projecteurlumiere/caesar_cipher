def caesar_cipher(string, shift)
  if shift >= 26 || shift <= 26
    shift = shift - ((shift / 26) * 26) # division returns not rounded integer
  end
  ciphered = string.split("").reduce("") do | newarray, symbol |
    if (symbol.ord >= 97 && symbol.ord <= 122) 
      if (symbol.ord + shift) < 97
        newarray << (symbol.ord + shift + 26).chr
      elsif (symbol.ord + shift) > 122
        newarray << (symbol.ord + shift - 26).chr 
      else
        newarray << (symbol.ord + shift).chr
      end
    elsif (symbol.ord >= 65 && symbol.ord <= 90)
      if (symbol.ord + shift) < 65
        newarray << (symbol.ord + shift + 26).chr
      elsif (symbol.ord + shift) > 90
        newarray << (symbol.ord + shift - 26).chr
      else
        newarray << (symbol.ord + shift).chr
      end
    else 
      newarray << symbol
    end
  end
  ciphered
end

puts "\nThis is Caesar ciphering machine\n"
puts "\nenter phrase:\n"
phrase = gets.chomp
puts "\nenter shift (any integer number):\n"
shift = gets.chomp.to_i

puts "\nhere is your ciphered text:\n\n" + caesar_cipher(phrase, shift)
