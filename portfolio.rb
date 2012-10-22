#portfolio class, which will contain stocks
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'stock'

class Portfolio

	attr_accessor :portfolio
	attr_accessor :short_stock

	#portfolio starts off as an empty hash that needs to be populated using the buy_stock method
	def initialize
		@portfolio = Hash.new
	end

	#buy stock into portfolio method
	def buy_stock (stock, amount)
		new_amount = @portfolio[stock].to_f + amount.to_f
		@portfolio[stock] = new_amount
	end	

	#sell stock method. Does not allow holdings of stock to be < 0 
	def sell_stock (stock, amount)
		new_amount = @portfolio[stock].to_f - amount.to_f
		if new_amount < 0 
			puts "Trade invalid. You cannot go short stock. Your holdings must be positive."
			@short_stock = true
		else	
			@portfolio[stock] = new_amount
			@short_stock = false
		end	
	end	 

	#displays the contents of the portfolio
	def display
		if @portfolio.empty?
			puts "Your portfolio is empty!"
		else	
			puts "Your portfolio holdings:"
			@portfolio.each do |stock, amount|
		 		puts "#{stock.display_name}: #{amount}"
			end
		end		
	end	

	def each
		@portfolio.each
	end	

	def empty?
		@portfolio.empty?
	end	

	def stock_amount(stock)
		@portfolio[stock]
	end	
	
	#calculates the value of the portfolio by summing the products of the stock amounts and prices
	def value
		portfolio_value = 0.0
		@portfolio.each do |stock, amount|
			stock_value = stock.price * amount.to_f
			portfolio_value = portfolio_value + stock_value
		end	
		portfolio_value.to_i
	end	

end





