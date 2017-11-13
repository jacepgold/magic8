# Jace P. Gold
# November 10th, 2017

# Done
# - Function to print all the answers
# Arrays for original bank of answers (@default_answers) -

# To Do

# Function to get answers from User (get_input(type = 'question'))
# if get_input, single line if statement thingy
# if get_input = 'answers', add answers to @answers array
# get_input = 'answers' will also check for duplicates, and alert
# the user to that the answer already exists

# Function to return a random answer

# Function when the user types QUIT or EXIT to say goodbye and exit 0

# Function to reset answers back to default bank (use arr.clone)

# Function to print all answers from @answers do.each loop

require 'pry'
require 'rainbow'

# Default answers source: https://en.wikipedia.org/wiki/Magic_8-Ball
# default_answers array is a restore point.
@default_answers = [
  'It is certain', 'It is decidedly so', 'Without a doubt', 'Yes definitely', 'You may rely on it',
  'As I see it, yes', 'Most likely', 'Outlook good', 'Yes', 'Signs point to yes', 'Reply hazy try again',
  'Ask again later', 'Better not tell you now', 'Cannot predict now', 'Concentrate and ask again',
  'Don\t count on it', 'My reply is no', 'My sources say no', 'Outlook not so good', 'Very doubtful'
]
# Clone the default answers. Use this array to add more answers from the user
@answers = @default_answers.clone


# Show all answers from @answers array of answers
def show_answers
  puts '----- All The Answers -----'
  @answers.each do |answer|
    puts answer
  end
end

# The actual game
def magic_eight
  puts "Type a question to get an answer, or type QUIT to end the program."
  print '> '
  question = $stdin.gets.strip
  question_downcase = question.downcase
  quit_program(question_downcase)
  if question.include?('easter')
    easter_egg_menu
  end
  puts 'The Magic 8 Ball says...'
  puts @answers.sample
  magic_eight
end

def quit_program(input)
  to_quit = input
  if to_quit == 'quit' || to_quit == 'exit'
    puts 'Magic 8 Ball shall be awaiting your return.'
    exit 0
  else
    return # Return straight to continue the script
  end
end

# Add answers to the answer array from the user
def add_to_answers(*args)
   if ARGV.any?
     args = ARGV.join(' ').split(', ')
     # DOWNCASE THIS WHEN YOU CAN FIGURE OUT HOW
     # Check to see if the item is already in the array of answers or not
     args.each do |i|
       @answers.push(i)
     end
     easter_egg_menu
   else
     new_answer = get_input
     if @answers.include?(new_answer.split(',').last)
       puts "Answer already exists. Please try again."
       add_to_answers
     else
       @answers.push(new_answer.split(',').last)
       easter_egg_menu
     end
     easter_egg_menu
   end
end

def reset_answers
  @answers = @default_answers
  puts @answers
end

# Get user input
def get_input
  puts 'Enter a new answer for the Magic Eight Ball, or type Quit to end the program.'
  print '> '
  input = $stdin.gets.strip
  input_downcase = input.downcase
  quit_program(input)
  to_return = input + ',' + input_downcase
end

# Main easter_egg_menu
def easter_egg_menu
   puts '----- Easter Egg Menu! Much more options to explore -----'
   puts '1.) Magic 8'
   puts '2.) Add Answers'
   puts '3.) Show Answers'
   puts '4.) Reset answers'
   puts '5.) Quit'
   print '> '
   choice = $stdin.gets.strip
   case choice
   when '1'
     magic_eight
     easter_egg_menu
   when '2'
     add_to_answers
     easter_egg_menu
   when '3'
     show_answers
     easter_egg_menu
   when '4'
     reset_answers
     easter_egg_menu
   when '5'
     exit 0
   else
     puts 'I didn\'t understand you. Please try again.'
     easter_egg_menu
   end
end

# If there are any Argument variables passed from the console, add those to the answers.
# Otherwise, go straight to the main easter_egg_menu
if ARGV.any?
  @argv_answers = ARGV
  add_to_answers
else
  magic_eight
end
