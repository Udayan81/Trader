#trader code - defining the profile of the player
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portfolio'

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
		trader_value = @portfolio.value.to_f + @cash_balance.to_f
		#why does this not add up the numbers???
		puts trader_value.to_f
	end	
end

#test
#udayan = Trader.new("Ud", 10000000)
#stock_a = Stock.new("StockA", 500, 0.25)
#stock_b = Stock.new("StockB", 75, 1.1)

#udayan.portfolio.buy_stock(stock_a,100)
#udayan.portfolio.buy_stock(stock_b,50)
#udayan.portfolio.display
#udayan.portfolio.value
#udayan.value

