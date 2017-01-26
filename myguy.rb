# 2nd attempt at hangman

class Hangman
		MAX_BODY_PARTS = 9

	def initialize(word)
		@word = word.split(//)
		@guessed = []
		@not_guessed = ('a' .. 'z').to_a
		@body_parts = 0
	end
	# returns true if all letters in @word are guessed
	def guessed?
		@word.each do |c|
			if not @guessed.include? c 
				return false
			end
		end
		true
	end
	# returns the word with guessed letters
	def word_line 
		line = ""
		@word.each do |c|
			if @guessed.include? c
				line << c
			else
				line << "_"
			end
			line << " "
		end
		line[0 .. -2]
	end
	# returns welcome message
	def welcome
		"Welcome to hangman.\n" +
			"You have 9 body parts to lose.\n"
	end
	def congrats
		"Congratulations, you won!"
	end
	def boohoo
		"Sorry, you lost."
	end
	def play
		puts
		puts
		puts "--------------------------------------------"
		puts welcome
		puts "--------------------------------------------"
		puts
		puts
		while true do
			if guessed?
				puts word_line
				puts congrats
				break
			end
			if lost?
				puts boohoo
				print "The word was - #{@word.join}.\n"
				break
			end
			move
		end
	end
	# one move in game
	def move
		puts "Body parts lost so far: "
		puts @body_parts
		puts
		puts word_line
		puts
		puts "Available letters: #{@not_guessed.join(" ")}"
		puts
		puts "Please enter a letter."
		x = gets.chomp
		@guessed << x 
		if not @word.include? x 
			@body_parts += 1			
		end
		@not_guessed.delete x
		puts

		print "\nGuessed letters: #{@guessed}.\n"
		puts "------------ "
	end
	def lost?
		@body_parts >= MAX_BODY_PARTS
	end
	def debug
		puts "@word = #@word"
		print "@guessed = "
		print @guessed
		puts 
		print "#@not_guessed = "
		print "@not_guessed\n"
	end
end

# get random word

file_contents = File.read "words.txt"
words = file_contents.split(" ")
word = words.sample

hangman = Hangman.new(word)
hangman.play
#hangman.debug
#puts hangman.guessed?
#hangman.move
