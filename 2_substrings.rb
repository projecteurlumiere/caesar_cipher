def substrings(string, dictionary)
  hash_result = Hash.new(0)
  string.downcase.split(" ").each do | word |
    dictionary.each do | dictionary_word |
      if word.include?(dictionary_word)
        hash_result["#{dictionary_word}"] += 1 
      end
    end
  end
  hash_result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
