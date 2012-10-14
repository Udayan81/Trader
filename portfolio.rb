#portfolio class, which will contain stocks
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'stock'

class Portfolio

	attr_accessor :portfolio

	#portfolio starts off as an empty hash that needs to be populated using the buy_stock method
	def initialize
		@portfolio = Hash.new
	end

	#buy stock into portfolio method
	def buy_stock (stock, amount)
		new_amount = @portfolio[stock].to_f + amount
		@portfolio[stock] = new_amount
	end	

	#sell stock method. Does not allow holdings of stock to be < 0 
	def sell_stock (stock, amount)
		new_amount = @portfolio[stock].to_f - amount
		if new_amount < 0 
			puts "Trade invalid. You cannot go short stock. Your holdings must be positive."
		else	
			@portfolio[stock] = new_amount
		end	
	end	 

	#displays the contents of the portfolio
	def display
		puts "Your portfolio holdings:"
		@portfolio.each do |stock, amount|
		 	puts "#{stock.display_name}: #{amount}"
		end	
	end	

	def each
		@portfolio.each
	end	
	
	#calculates the value of the portfolio by summing the products of the stock amounts and prices
	def value
		portfolio_value = 0.0
		@portfolio.each do |stock, amount|
			stock_value = stock.price * amount.to_f
			portfolio_value = portfolio_value + stock_value
		end	
		puts portfolio_value.to_f
	end	

end

#tests
#stock_a = Stock.new("StockA", 500, 0.25)
#stock_b = Stock.new("StockB", 75, 1.1)

#my_portfolio = Portfolio.new
#my_portfolio.buy_stock(stock_a, 10)
#my_portfolio.buy_stock(stock_b, 100)
#my_portfolio.display
#puts my_portfolio.value

#my_portfolio.buy_stock(stock_a, 20)
#my_portfolio.sell_stock(stock_b, 113)
#my_portfolio.display
#my_portfolio.value




