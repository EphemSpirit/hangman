class Board

  #This class will initialize the board for Hangman
  #upon intialization, it will choose a random word from the input dictionary file
  #and display and number of udnerscores equalling the length of the chosen word

  #attr_reader for generated word?
  attr_reader :word, :lines

  def initialize
    #display the game rules
    #initialize the board
    #read in the dictionary, and choose a random word between 5 and 12 characters
    #display the underscores
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
  end

  def update_display
    #this function will update the game display after each turn, displaying correct guesses
    #in the correct word-internal position
    #if the user hits the ceiling on incorrect guesses, display will show "You're out of guesses! The word was #{generated_word}. Better luck next time :)"
  end

  def generate_word()
    File.read("5desk.txt").lines.select{ |line| (5..12).cover?(line.strip.size)}.sample.strip
  end
end

b = Board.new
b
