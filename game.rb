require 'msgpack'

class Game

  #this class will handle the internal game logic
  #attr_reader for array of guessed letters, as well as the word (sequence of underscores/letters that the player is working with)
  @@incorrect_guesses = 0

  attr_accessor :word, :lines

  def initialize
    #initialize with a new Board object
    #will also initialize an empty array to house already guessed letters
    #set a class variable that iterates the number of incorrect guesses
    @guesses = []
    @word = generate_word()
    @lines = Array.new(@word.length, "_")
    puts "===================================="
    puts "======= Welcome to Hangman! ========"
    puts "====================================\n"
    puts "The rules are simple: You have to guess the secret word!"
    puts "Seven wrong guesses and the game will end."
    puts "Guessing a letter you've already tried won't count against you. Good luck!\n\n\n"
    print @lines
    puts
    puts
    take_turn()
  end

  def check_for_save
    #check for a saved game, and if one is found, ask if the user would like to load it
  end

  def take_turn()

    until @lines.join == @word || @@incorrect_guesses == 7
      puts "Choose a letter!"
      @guess = gets.chomp.downcase
      if @guesses.include?(@guess)
        puts "Letter already chosen! Try again."
      else
        if word.include?(@guess)
          @guesses.push(@guess)
          update_display()
        else
          @@incorrect_guesses += 1
          @guesses.push(@guess)
          puts "That letter is not in the word :("
          puts "Number of wrong guesses: #{@@incorrect_guesses}"
        end
      end
    end
  end

  #maybe move this one over to Board.rb
  def update_display
    matches = (0...@word.length).find_all{ |i| @word[i, 1] == @guess }
    matches.each do |idx|
      lines[idx] = lines[idx].sub("_", @guess)
    end
    print @lines
    puts
    if !more_tries?()
      puts "Out of attempts! The word was #{@word}. Better luck next time!"
    end
  end

  def word_complete?(word_to_guess)
    #if word_to_guess == generated word, the game is over
  end

  def more_tries?
    @@incorrect_guesses != 7 ? true : false
  end

  def to_msgpack()
    #this function will serialize the current game data and output it to a Marshall binary file to be loaded back in later
    MessagePack.dump ({
      :lines => @lines,
      :word => @word,
      :guesses => @guesses,
      :incorrect_guesses => @@incorrect_guesses,
      })
  end

  def self.from_msgpack(string)
    #if user selects to load a previous game, deserialize the saved game file and initialize a new game with that data
    data = MessagePack.load string
    self.new(data['lines'], data['word'], data['guesses'], data['incorrect_guesses'])
  end

  def generate_word()
    File.read("5desk.txt").lines.select{ |line| (5..12).cover?(line.strip.size)}.sample.strip
  end
end

game = Game.new
game
