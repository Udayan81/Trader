#trader code - defining the profile of the player
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portfolio'
require 'stock'

class Trader

	attr_accessor :name
	attr_accessor :cash_balance
	attr_accessor :portfolio

	def initialize (name, cash_balance)
		@name = name
		@cash_balance = cash_balance.to_f 
		@portfolio = Portfolio.new
	end	

	def value
		trader_value = (@portfolio.value.to_i + @cash_balance.to_i)
		trader_value.to_i
	end	
end

