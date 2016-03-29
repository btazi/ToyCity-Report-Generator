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
	$stdout = File.new('report.txt', 'w')
	def print_heading
		# Print today's date
		puts "Today: #{Time.now.strftime("%d/%m/%Y")}"
	end

	def print_data

		def separator
			puts "----------------------------------"
		end

		def make_products_section

			def print_heading
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
				$products_hash["items"].each do |toy|
					
					def print_name(toy)
						# Print the name of the toy
						puts toy["title"]
					end

					def retail_price(toy)
						toy["full-price"]
					end

					def print_price(toy)
						# Print the retail price of the toy
						puts "retail price: #{retail_price(toy)}"
					end

					def purchases_count(toy)
						toy["purchases"].length
					end

					def print_purchases_count(toy)
						# Calculate and print the total number of purchases
						puts "number of purchases: #{purchases_count(toy)}"
					end

					def sales(toy)
						sales = 0
						toy["purchases"].each do |p|
							sales += p["price"]
						end
						return sales
					end

					def print_sales(toy)
						# Calculate and print the total amount of sales
						puts "sales: #{sales(toy)}"
					end

					def average_price(toy)
						sales(toy)/purchases_count(toy)
					end
					
					def print_average_price(toy)
						# Calculate and print the average price the toy sold for
						puts "average_price: #{average_price(toy)}"
					end

					def print_average_discount(toy)
						# Calculate and print the average discount (% or $) based off the average sales price
						average_discount = (((retail_price(toy).to_f - average_price(toy).to_f)/retail_price(toy).to_f)*100).round(2)
						puts "average discount: #{average_discount}%"		
					end

					print_name toy
					print_price toy
					print_purchases_count toy
					print_sales toy
					print_average_price toy
					separator

				end
			end

			print_heading
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







