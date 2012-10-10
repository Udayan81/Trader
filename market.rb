#Game controller code 

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portfolio'
require 'trader'

class Market

	def initialize ()
		@portfolio = Portfolio.new
		@trader = Trader.new

	end

	def trading_session

	end

	def choose_stocks

	end	

	def news

	end
	
	def rumours

	end	

end
