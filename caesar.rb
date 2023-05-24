def define_ascii(newstring, symbol, shift, min_ascii, max_ascii)
  if (symbol.ord + shift) < min_ascii
    newstring << (symbol.ord + shift + 26).chr
  elsif (symbol.ord + shift) > max_ascii
    newstring << (symbol.ord + shift - 26).chr 
  else
    newstring << (symbol.ord + shift).chr
  end
end

def caesar_cipher(string, shift)
  shift = shift - ((shift / 26) * 26) # division returns not rounded integer
  ciphered = string.split("").reduce("") do | newstring, symbol |
    if (symbol.ord >= 97 && symbol.ord <= 122) 
      define_ascii(newstring, symbol, shift, 97, 122)
    elsif (symbol.ord >= 65 && symbol.ord <= 90)
      define_ascii(newstring, symbol, shift, 65, 90)
    else 
      newstring << symbol
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
