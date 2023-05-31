module Mastermind
  DICTIONARY = ["A", "B", "C", "D", "E", "F"]

  class Game
    def initialize(player_class, computer_class)
      @player = player_class.new(self)
      @computer = computer_class.new(self)
      start_game
    end

    def get_information_about_round
      @information = Array.new(3, 0)
      @information[0] = @round

      if @guess_result != nil
        i = 1
        @guess_result.each do |number|
          @information[i] = number
          i += 1
        end
      end

      @information
    end
    
    private

    def start_game
      @max_rounds = 12
      @round = 1
      if @player.wants_to_guess?
        @cipher = @computer.get_random_code
        @address = "You"
        play(@player, @cipher)
      else
        puts "\nThink of a code for computer to crack. Four letters A to F. No repeats\n"
        @cipher = @player.get_a_code_array
        @address = "Computer"
        play(@computer, @cipher)
      end
    end

    def play(who_guesses, cipher)
      play_rounds(who_guesses)

      announce_gameover(cipher, @guess_result)
      
      offer_replay
    end

    def play_rounds(who_guesses)
      @max_rounds.times do
        puts "\n\nROUND #{@round} out of #{@max_rounds}\n"
        puts "\nMake a guess. Four letters A to F. No repeats\n" if @address == "You"
        @guess = who_guesses.get_a_code_array

        puts "\n#{@address} made a guess of \n#{@guess.join.upcase}\n"
        @guess_result = assess_a_guess(@guess, @cipher)
        puts "#{@address} guessed #{@guess_result[0]} letters and #{@guess_result[1]} positions\n"
        @round += 1

        break if @guess_result[1] == 4
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

    def announce_gameover(cipher, guess_result)
      if guess_result[1] == 4
        puts "\nGAME OVER\n\nYOU WIN!\n" if @address == "You"
        puts "\nGAME OVER\n\nCOMPUTER WINS!\n" if @address == "Computer"
      else
        puts "\nThe cipher was #{cipher.join.upcase}\n\nGAME OVER\n\nYOU LOSE!\n" if @address == "You"
        puts "\nThe cipher was #{cipher.join.upcase}\n\nGAME OVER\n\nCOMPUTER LOSES!\n" if @address == "Computer"
      end
    end
    
    def offer_replay
      puts "\nAnother one? Yes or No\n"
      if another_one?
        start_game
      else
        puts "\nbye!\n"
      end
    end 

    def another_one?
      @response = gets.chomp.downcase
      until @response == 'yes' || @response == 'no' || @response == 'y' || @response == 'n'
        puts "Come again"
        another_one?
      end
      if @response== 'yes' || @response == 'y'
        true
      elsif @response == 'no' || @response == 'n'
        false
      end
    end
  end

  class Player
    def initialize(game)
      @game = game
    end

    def wants_to_guess?
      puts "\nDo you want to be the one who makes guesses? Yes or No\n"
      @response = gets.chomp.downcase
      until @response == 'yes' || @response == 'no' || @response == 'y' || @response == 'n'
        puts "\nCome again\n"
        wants_to_guess?
      end
      if @response == 'yes' || @response == 'y'
        true
      elsif @response == 'no' || @response == 'n'
        false
      end
    end 

    def get_a_code_array
      @guess = gets.chomp.delete(' ').delete(',').upcase.split("")
      until @guess.length == 4 && @guess.uniq.length == @guess.length && @guess.all? { |letter| DICTIONARY.include?(letter) }
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
      DICTIONARY.sample(4)
    end

    def get_a_code_array
      @round_info = @game.get_information_about_round
      if @round_info[0] == 1 || @round_info[1] == 0
        @guess = DICTIONARY.sample(4)
        @guess
      elsif @round_info[0] != 1
        @guess = make_informed_decision(@round_info)
        @guess
      end
    end

    private 

    def make_informed_decision(round_info)
      @new_guess = []

      loop do
        @new_guess = @guess.sample(round_info[1]) + DICTIONARY.sample(4 - round_info[1])
        break if @new_guess.length == @new_guess.uniq.length
      end

      return @new_guess.shuffle
    end
  end
end

include Mastermind

game = Game.new(Player, Computer)