<h1>Command Line Hangman</h1>

Simple command line game of hangman! The game reads in a dictionary file, and then chooses a word at random that is between
five and twelve characters long. 

The player is shown an array of underscores representing the empty spaces left in the word, and if they guess a letter correctly,
the underscores will be replaced by that letter, wherever that letter appears in the word.

Players get 10 wrong guesses before the game exits and shows them what the word was!

The main purpose of this project is to use serialization in Ruby, letting the player save and load their game if they want to
stop in the middle of a game and resume it later.

Built as part of <i>The Odin Project</i> curriculum.
