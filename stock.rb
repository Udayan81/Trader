#stock objects

class Stock

	attr_accessor :stock_name
	attr_accessor :price
	attr_accessor :vol

	#define the stock with a name, initial price and a volatility to determine the range of the price movements
	def initialize (stock_name, price, vol, des)
		@stock_name = stock_name
		@price = price.to_f
		@vol = vol
		@des = des
	end	
	
	#method that generates a random positive price movement bounded by the volatility of the stock
	def pos_price_movement
		price_hi = @price * ( 1 + @vol )
		@price = rand (@price..price_hi)
	end	

	#method that generates a random negative price movement bounded by the volatility of the stock
	def neg_price_movement
		price_lo = @price * ( 1 - @vol )
		@price = rand (price_lo..@price)
	end

	def display
		puts "Name: #{@stock_name} \n Price: #{@price} \n Volatility: #{@vol}"
	end
	
	def display_name
		puts @stock_name
	end

	def des
		@des
	end	

	def price
		@price
	end	
end

