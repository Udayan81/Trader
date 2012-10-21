#SUPERSTAR TRADER GAME

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'market'
require 'trader'

puts "Welcome to SUPERSTAR TRADER\n"
puts "The aim of the game is to spend your 1,000,000 wisely on stocks. Beware, some are riskier than others!"
puts "Please enter your Name:"
Username =  $stdin.gets.chomp

#new game is set up with the Username, a 1,000,000 opening cash balance and 6 trading sessions 
superstar = Market.new(Username, 1000000, 6)
superstar.play_game