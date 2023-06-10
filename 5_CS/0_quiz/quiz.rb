# https://www.codequizzes.com/computer-science/beginner/recursion

def factorial(n)
  return 1 if n == 0

  n * factorial(n - 1)
end

def palindrome(string)
  if string != nil
    if string[0] == string[-1]
    palindrome(string[1..-2])
    else
      false
    end
  else
    true
  end
end

def beer(bottles = 0)
  if bottles == 0
    puts 'No more bottles of beer on the wall'
  else
    puts "#{bottles} bottles of beer on the wall"
    beer(bottles - 1)
  end
end

def fibonacci(n)
  if n == 0 
    0
  elsif n == 1
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

array.flatten

roman_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def integer_to_roman(roman_mapping, number, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return integer_to_roman(roman_mapping, modulus, result) if quotient > 0
  end
end

def roman_to_integer(roman_mapping, str, result = 0)
  return result if str.empty?
  roman_mapping.keys.each do |roman|
    if str.start_with?(roman)
      result += roman_mapping[roman]
      str = str.slice(roman.length, str.length)
      return roman_to_integer(roman_mapping, str, result)
    end
  end
end