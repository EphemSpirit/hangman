require 'json'

Dir = "hangman"

class Game

  @@incorrect_guesses = 0

  attr_accessor :word, :lines

  def initialize(*save_file)
    @guesses = []
    @word = generate_word()
    @lines = Array.new(@word.length, "_")
    puts "===================================="
    puts "======= Welcome to Hangman! ========"
    puts "====================================\n"
    puts "The rules are simple: You have to guess the secret word!"
    puts "Seven wrong guesses and the game will end."
    puts "Guessing a letter you've already tried won't count against you."
    puts "If you'd like to save your game ad come back later, just submit 'save', as your guess."
    puts "Good luck!\n\n\n"
    print "The word is #{@lines.length} letters long:"
    puts
    puts
    take_turn
  end

  def check_for_save
    saved_game = "saved_game.json"
    if saved_game.exists?
      puts "Would you like to load the previous game file? (y/n)"
      response = gets.chomp
      if response == "y"
        self.load_game(saved_game)
        Game.new(save_game)
      else
        Dir.rm "saved_game.json"
        Game.new
      end
    end
  end

  def take_turn
    until word_complete? || @@incorrect_guesses == 7
      puts "Choose a letter!"
      @guess = gets.chomp.downcase
      if @guesses.include?(@guess)
        puts "Letter already chosen! Try again.\n\n"
      elsif @guess == 'save'
        save_game
        exit
      else
        if word.include?(@guess)
          @guesses.push(@guess)
          update_display()
        else
          @@incorrect_guesses += 1
          @guesses.push(@guess)
          if !more_tries?
            puts puts "Out of attempts! The word was #{@word}. Better luck next time!"
            exit
          else
            puts "That letter is not in the word :("
            puts "Number of wrong guesses: #{@@incorrect_guesses}\n\n"
          end
        end
      end
    end
  end

  def update_display
    matches = (0...@word.length).find_all{ |i| @word[i, 1] == @guess }
    matches.each do |idx|
      lines[idx] = lines[idx].sub("_", @guess)
    end
    print @lines.join(" ")
    puts
    puts
  end

  def word_complete?
    if @lines.join == @word
      puts "You guessed the word (#{@word})! Congratulations :)"
      exit
    end
  end

  def more_tries?
    @@incorrect_guesses != 7 ? true : false
  end

  private

  def save_game
    save_file = File.open("saved_game.json", "w")
    save_file.write(@game.to_json)
    save_file.close
    p save_file
  end

  def load_game(string)
    save_file = SaveFile.new("saved.json")
    json = save_file.read
    JSON::load(json)
  end

  def generate_word()
    File.read("5desk.txt").lines.select{ |line| (5..12).cover?(line.strip.size)}.sample.strip.downcase
  end
end

game = Game.new
game.check_for_save
