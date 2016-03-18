require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
products_hash["items"].each do |toy|
	# Print the name of the toy
	puts "name: #{toy["title"]}"
	# Print the retail price of the toy
	retail_price = toy["full-price"]
	puts "retail price: #{retail_price}"
	# Calculate and print the total number of purchases
	number_of_purchases = toy["purchases"].length
	puts "number of purchases: #{number_of_purchases}"
	# Calculate and print the total amount of sales
	sales = 0
	toy["purchases"].each do |p|
		sales += p["price"]
	end
	puts "sales: #{sales}"
	# Calculate and print the average price the toy sold for
	average_price = sales/number_of_purchases
	puts "average_price: #{average_price}"
	# Calculate and print the average discount (% or $) based off the average sales price
	average_discount = (((retail_price.to_f - average_price.to_f)/retail_price.to_f)*100).round(2)
	puts "average discount: #{average_discount}%"		
	puts "----------------------------------"
end


puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts

# For each brand in the data set:
brands = products_hash["items"].map { |toy| toy["brand"] }.uniq
brands.each do |brand|

	stock = 0
	average = 0
	revenue = 0
	toys = products_hash["items"]
	toys.each do |toy|
		if toy["brand"] == brand
			stock += toy["stock"]
			average += toy["full-price"].to_f
			toy["purchases"].each do |purchase|
				revenue += purchase["price"]
			end
		end
	end
	
	# Print the name of the brand
	puts brand
	# Count and print the number of the brand's toys we stock
	puts "stock: #{stock}"
	# Calculate and print the average price of the brand's toys
	average = (average/toys.size).round(2)
	puts "average price: #{average}"
	# Calculate and print the total revenue of all the brand's toy sales combined
	puts "revenue: #{revenue.round(2)}$"	
	puts "-----------------------------------"
end
