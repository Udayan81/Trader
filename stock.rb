#stock objects

class Stock

	attr_accessor :stock_name
	attr_accessor :price
	attr_accessor :vol

	#define the stock with a name, initial price and a volatility to determine the range of the price movements
	def initialize (stock_name, price, vol)
		@stock_name = stock_name
		@price = price.to_f
		@vol = vol
	end	
	
	def pos_price_movement
		price_hi = @price * ( 1 + @vol )
		@price = rand (@price..price_hi)
	end	

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

	def price
		@price
	end	
end

#test
#stock_udayan = Stock.new("Udayan", 1000, 0.5)

#puts stock_udayan.stock_name
#puts stock_udayan.price
#puts stock_udayan.vol

#stock_udayan.pos_price_movement
#puts stock_udayan.price

#stock_udayan.neg_price_movement
#puts stock_udayan.price


