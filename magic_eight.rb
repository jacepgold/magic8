# Jace P. Gold
# November 10th, 2017

# Done
# - Function to print all the answers
# Arrays for original bank of answers (@default_answers) -
# Function when the user types QUIT or EXIT to say goodbye and exit 0
# Function to reset answers back to default bank
# if get_input = 'answers', add answers to @answers array
# Function to print all answers from @answers do.each loop

# To Do
# get_input = 'answers' will also check for duplicates, and alert
# the user to that the answer already exists
# Add color to the output text

require 'pry'
require 'rainbow'
require_relative 'default_responses'

# Clone the default answers. Use this array to add more answers from the user
@answers = @default_answers.clone


# Show all answers from @answers array of answers
def show_answers
  puts "\n\t----- All The Answers -----\n"
  @answers.each do |answer|
    puts answer
  end
end

# The actual game
def magic_eight
  puts "\n\t------ MAGIC 8 BALL ------\n"
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
    puts "\tMagic 8 Ball shall be awaiting your return."
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
       puts "\n\tAnswer has been added.\n"
       easter_egg_menu
     end
     easter_egg_menu
   end
end

def reset_answers
  @answers = @default_answers.clone
  puts "\n\tAnswers Have Been Reset\n"
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
   puts "\n\t----- Easter Egg Menu! Much more options to explore -----\n"
   puts '1.) Magic 8'
   puts '2.) Add Answers'
   puts '3.) Show Answers'
   puts '4.) Reset answers'
   puts '5.) Quit'
   print '> '
   choice = $stdin.gets.strip.downcase
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
     choice = 'quit'
     quit_program(choice)
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
