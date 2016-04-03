require 'json'

def start
	setup_files
	create_report
end

def setup_files
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$products_hash = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end

def create_report
	def print_heading
		$stdout = File.new('report.txt', 'w')
		puts "   _____       _             _____                       _    "
		puts "  / ____|     | |           |  __ \\                     | |   "
		puts " | (___   __ _| | ___  ___  | |__) |___ _ __   ___  _ __| |_  "
		puts "  \\___ \\ / _` | |/ _ \\/ __| |  _  // _ \\ '_ \\ / _ \\| '__| __| "
		puts "  ____) | (_| | |  __/\\__ \\ | | \\ \\  __/ |_) | (_) | |  | |_  "
		puts " |_____/ \\__,_|_|\\___||___/ |_|  \\_\\___| .__/ \\___/|_|   \\__| "
		puts "                                       | |                    "
		puts "                                       |_|                    "
		# Print today's dateVV
		puts "Today: #{Time.now.strftime("%d/%m/%Y")}"
	end

	def print_data

		def separator
			puts "----------------------------------"
		end

		def make_products_section

			def print_products_heading
				puts "                     _            _       "
				puts "                    | |          | |      "
				puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
				puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
				puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
				puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
				puts "| |                                       "
				puts "|_|                                       "
			end
		
			def print_info
				# For each product in the data set:
					

					def average_price(toy)
						sales = toy["purchases"].inject(0) {|total, purchase| total += purchase["price"]}
						count = toy["purchases"].count
						sales/count
					end

					def average_discount(toy)
						retail = toy["full-price"]
						average = average_price toy
						(((retail.to_f - average.to_f)/retail.to_f)*100).round(2)
					end

					def products_data
						$products_hash["items"].each do |toy|
							toy_result = calculate_products_data(toy)
							print_products_data(toy_result)
						end
					end

					def calculate_products_data(toy)
						toy_data = {name: toy["title"], retail: toy["full-price"], sales: toy["purchases"].inject(0) {|result, purchase| result += purchase["price"] }, count: toy["purchases"].count, average_price: average_price(toy), average_discount: average_discount(toy) }
						toy_data
					end

					def print_products_data(toy_result)
						puts "#{toy_result[:name]}"
						puts "retail price: #{toy_result[:retail]}"
						puts "number of purchases: #{toy_result[:count]}"
						puts "sales: #{toy_result[:sales]}"
						puts "average price: #{toy_result[:average_price]}$"
						puts "average discount: #{toy_result[:average_discount]}%"
						separator
					end

					products_data
			end

			print_products_heading
			print_info
		end

		def make_brands_section

			def print_heading
				puts "                                 "
				puts " _                         _     "
				puts "| |                       | |    "
				puts "| |__  _ __ __ _ _ __   __| |___ "
				puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
				puts "| |_) | | | (_| | | | | (_| \\__ \\"
				puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
				puts
			end

			def print_info

				def print_all_brands_info
				$brands = $products_hash["items"].map { |toy| toy["brand"] }.uniq

					def get_brand_info(brand)
						@toys = $products_hash["items"].select { |toy| toy["brand"] == brand }

						def get_stock(brand)
							@toys.inject(0) {|toy_stock, toy| toy_stock += toy["stock"] }
						end

						def get_average(brand)
							get_toys_count(brand)
							average = @toys.inject(0) {|toy_average, toy| toy_average += toy["full-price"].to_f }
							(average/get_toys_count(brand)).round(2)
						end

						def get_toys_count(brand)
							@toys.count
						end

						def get_revenue(brand)
							total_revenue = @toys.inject(0) {|revenue, toy|	revenue += toy["purchases"].inject(0) { |toy_revenue, purchase| toy_revenue += purchase["price"]  } }
							total_revenue.round(2)
						end

						get_stock(brand)
						get_average(brand)
					end


					def print_brand_info(brand)
						# Print the name of the brand
						puts brand
						# Count and print the number of the brand's toys we stock
						puts "stock: #{get_stock(brand)}"
						# Calculate and print the average price of the brand's toys
						puts "average price: #{get_average(brand)}"
						# Calculate and print the total revenue of all the brand's toy sales combined
						puts "revenue: #{get_revenue(brand)}$"	
						puts "-----------------------------------"
					end
					# For each brand in the data set:
					
					$brands.each do |brand|
						brand = get_brand_info(brand)
						print_brand_info(brand)
					end

				end

				print_all_brands_info
			end

			print_heading
			print_info
		end

		make_products_section
		make_brands_section
	end

	print_heading
	print_data
end

start







