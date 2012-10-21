#Game controller code 

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portfolio'
require 'trader'
require 'stock'

class Market

	attr_accessor :trader
	attr_accessor :sessions
	attr_accessor :starting_cash


	#Game is initialized with the trader having a defined amount of cash and a set number of trading sessions
	def initialize (trader, cash, sessions)
		@trader = Trader.new(trader, cash)
		@sessions = sessions
		@starting_cash = cash
		#set up the 'stockmarket' by creating stocks and putting them into an array
		@g_a = Stock.new("General_Assembly", 200, 0.15)
		@r_l = Stock.new("Lomas", 100, 0.25)
		@aapl = Stock.new("Apple", 750, 0.05)
		@ud = Stock.new("Udayan", 75, 0.75) 
		@stockmarket = [@g_a, @r_l, @aapl, @ud]
	end

	def trading_session
		market_driver = rand(1..2)
	end

	def news(market_move)
		if market_move == 1 then
			for stock in @stockmarket
			 	stock.neg_price_movement
			end
		elsif market_move == 2 then
			for stock in @stockmarket
			 	stock.pos_price_movement
			end
		else
			raise 
		end		 	
	end

	def display_portfolio	
		@trader.portfolio.display
	end

	def value
		puts @trader.value
	end	

	def play_game
		sessions_count = 1
		loop do

			puts "================================================="
			puts "Trading Session Number: #{sessions_count} \a\a\n"
			puts "================================================="
			display_portfolio
			puts "#{@trader.name}, do you wish to change your portfolio? (Y / N)"
			user_choice = $stdin.gets.chomp.upcase
			user_choice = check_input(user_choice, "Y", "N")
			if user_choice == "Y" then
				trade_stocks
				news(trading_session)
				display_portfolio
				puts "The value of your stock portfolio is #{@trader.portfolio.value}"
				puts "Your cash balance is #{@trader.cash_balance}"
				puts "#{@trader.name}, your net worth is #{@trader.value}"

			elsif user_choice == "N" then	
				news(trading_session)
				display_portfolio
				puts "The value of your stock portfolio is #{@trader.portfolio.value} \n"
				puts "Your cash balance is #{@trader.cash_balance.to_i} \n"		
				puts "#{@trader.name}, your net worth is #{@trader.value}\n"
			else
				raise
				#user_choice = check_input(user_choice, "Y", "N")
				#sessions_count = sessions_count - 1 
			end
			sessions_count = sessions_count + 1
			break if sessions_count > @sessions
		end					
		end_game
	end	

	def end_game
		puts "End of Game. #{@trader.name}, your total value is: #{@trader.value}.\n"
		total_profit = @trader.value.to_f - @starting_cash.to_f
		total_return = 100*((total_profit / @starting_cash))
		puts "Your final Profit & Loss account is #{total_profit}."
		puts "Your return was #{total_return}%"
	end

	def trade_stocks
		loop do
			for stock in @stockmarket
				stock_holding = @trader.portfolio.stock_amount(stock)
				puts "Your current holding of #{stock.stock_name} is #{stock_holding} "
				puts "Do you wish to trade #{stock.stock_name} at #{stock.price}? (Y / N)"
				to_trade = $stdin.gets.chomp.upcase
				to_trade = check_input(to_trade, "Y", "N")
				if to_trade == "Y" then
					buy_sell(stock)		
				elsif to_trade == "N" then
					next stock	
				else
					raise
				end	
			end
			puts "Have you finished all your trades for this session? (Y / N)\n"
			done_trading = $stdin.gets.chomp.upcase
			done_trading = check_input(done_trading, "Y", "N")
			break if done_trading == "Y"
		end	
	end	

	def check_input(input, ans1, ans2)
		if input == ans1
			return input
		elsif input == ans2
			return input
		else
			puts "You must enter #{ans1} or #{ans2}. Please try again.."
			input = $stdin.gets.chomp.upcase
			check_input(input, ans1, ans2) 
			return input
		end	
		return input	
	end		

	def check_number(input)
		if input.integer? then
			return input
		elsif input.integer? == false
			puts "You must enter an integer. Please try again.."
			input = $stdin.gets.chomp.to_i
			check_number(input)
			return input
		else
			raise
		end
		return input
	end		

	def buy_sell(stock)
		if @trader.portfolio.empty? then
			puts "Your portfolio is empty, you can only buy stock."
			buy_or_sell = "B"
		else	
			puts "Do you wish to buy or sell #{stock.stock_name}? (B / S)"
			buy_or_sell = $stdin.gets.chomp.upcase
			buy_or_sell = check_input(buy_or_sell, "B", "S")
		end 
					
		if buy_or_sell == "B" then
			buy_trade(stock)
		elsif buy_or_sell == "S" then
			sell_trade(stock)
		else
			raise								
		end			
	end	

	def buy_trade (stock)
		maximum_buy_amount = @trader.cash_balance / stock.price 
		puts "Your current cash balance of #{@trader.cash_balance} allows you to buy #{maximum_buy_amount.to_i}.\n "
		puts "How much of #{stock.stock_name} do you want to buy?"
		buy_amount = $stdin.gets.chomp.to_f
		buy_amount = check_number(buy_amount)
		if buy_amount > maximum_buy_amount then
			puts "Sorry - you do not have enough cash to buy this much stock. \n"
			maximum_buy_amount = @trader.cash_balance / stock.price
			puts "The maximum amount of stock you can buy is #{maximum_buy_amount.to_i}"
			buy_sell (stock)
		else
			@trader.portfolio.buy_stock(stock, buy_amount)
			@trader.cash_balance = @trader.cash_balance - (stock.price*buy_amount)		
		end
			
	end

	def sell_trade (stock)
		puts "How much of #{stock.stock_name} do you want to sell?"
		sell_amount = $stdin.gets.chomp.to_i
		sell_amount = check_number(sell_amount)
		@trader.portfolio.sell_stock(stock, sell_amount)
		if @trader.portfolio.short_stock == true then
			@trader.cash_balance = @trader.cash_balance 
			stock_holding = @trader.portfolio.stock_amount(stock)
			puts "The maximum amount you can sell is #{stock_holding}"
			buy_sell (stock)
		elsif @trader.portfolio.short_stock == false then
			@trader.cash_balance = @trader.cash_balance + (stock.price*sell_amount)
		else
			raise RuntimeError
		end		
	end	

end

#test
#market1 = Market.new("udayan", 1000000,2)

#market1.play_game


#market1.trader.portfolio.buy_stock(market1.g_a,50)
#market1.trader.portfolio.buy_stock(market1.r_l,25)
#market1.display_portfolio
#market1.value
#market1.news(1)
#market1.display_portfolio
#market1.value
#market1.news(market1.trading_session)
#market1.display_portfolio
#market1.value

