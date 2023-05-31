CODE = ["A", "B", "C", "D", "E", "F"]

class Game
  def initialize(player_class, computer_class)
    @player = player_class.new(self)
    @computer = computer_class.new(self)
    start_game
  end
  
  private

  def start_game
    @max_rounds = 12
    @round = 1
    if @player.wants_solve?
      @cipher = @computer.get_random_code
      play_against_computer(@cipher)
    else
      puts "\nThink of a code for computer to crack. Four letters A to F. No repeats\n"
      @cipher = @player.get_random_code
    end
  end

  def play_against_computer(cipher)
    @max_rounds.times do
      puts "\nRound #{@round} out of #{@max_rounds}\n\nMake a guess. Four letters A to F. No repeats\n"
      @guess = @player.get_a_code_array
      @guess_result = assess_a_guess(@guess, cipher)
      puts "\nYou guessed #{@guess_result[0]} letters and #{@guess_result[1]} [positions]"
      @round += 1
      break if @guess_result[1] == 4
    end
    if @guess_result[1] == 4
      puts "\nGAME OVER\n\nYOU WIN!\n"
    else
      puts "\nGAME OVER\n\nYOU LOSE!\n"
    end
  end

  def assess_a_guess(guess, cipher)
    @letters_guessed = 0
    @places_guessed = 0
    guess.each_with_index do |letter, index|
      if cipher.any?(letter)
        @letters_guessed += 1
        if cipher.find_index(letter) == index
          @places_guessed += 1
        end
      end
    end
    [@letters_guessed, @places_guessed]
  end

end

class Player
  def initialize(game)
    @game = game
  end

  
  def wants_solve?
    puts "\nDo you want to solve the puzzle? Yes or No\n"
    @response = gets.chomp.downcase
    until @response == 'yes' || @response == 'no'
      puts "\nCome again\n"
      solve?
    end
    if @response == 'yes'
      true
    elsif @response == 'no'
      false
    end
  end 

  def get_a_code_array
    @guess = gets.chomp.delete(' ').delete(',').upcase.split("")
    p @guess
    until @guess.length == 4 && @guess.uniq.length == @guess.length && @guess.all? { |letter| CODE.include?(letter) }
      puts "\nCome again\n"
      get_a_code_array
    end
    @guess
  end
end

class Computer
  def initialize(game)
    @game = game
  end
  
  def get_random_code
    CODE.sample(4)
  end
end

game = Game.new(Player, Computer)