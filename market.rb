#Game controller code 

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portfolio'
require 'trader'
require 'stock'

class Market < Stock

	attr_accessor :trader
	attr_accessor :g_a
	attr_accessor :r_l

	#Set up the market, by creating Stocks that can be traded in the game
	#@g_a = Stock.new("General_Assembly", 200, 0.3)
	#@r_l = Stock.new("Lomas", 100, 0.8) 


	#Game is initialized with the trader having a defined amount of cash
	def initialize (trader, cash)
		@trader = Trader.new(trader, cash)
	end

	def trading_session
		market_driver = rand(0..1)
		puts market_driver
	end

	def news(market_move)
		portfolio = @trader.portfolio
		market_move = case 
		when 0 then 
			 portfolio.each do |stock, amount|
			 	stock.neg_price_movement
			 end	
		when 1 then
			 portfolio.each do |stock, amount|
			 	stock.pos_price_movement
			 end
		else
			puts "error"
		end		 	
	end

	def display_portfolio
		puts @trader.portfolio.display
	end

	def value
		puts @trader.portfolio.value
	end	

end

g_a = Stock.new("General_Assembly", 200, 0.3)
r_l = Stock.new("Lomas", 100, 0.8) 

market1 = Market.new("udayan", 1000000)

market1.trader.portfolio.buy_stock(g_a,50)
market1.trader.portfolio.buy_stock(r_l,25)
market1.trading_session

market1.display_portfolio
#market1.value
puts g_a.display

market1.news(1)

puts g_a.display
#market1.display_portfolio
#market1.value

