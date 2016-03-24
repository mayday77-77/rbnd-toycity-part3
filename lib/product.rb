class Product

	attr_reader :title, :price, :stock

	@@products = []

	def initialize(options = {})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_to_product
	end

	def in_stock?
		# need to reverse the boolean because if zero? is true, it means we have no stock, thus the need to return false
		!@stock.zero?
	end

	def reduce_stock_count
		@stock -= 1
	end

	def self.all
		@@products
	end

	# Using enumerable method find to see if title exists
	def self.find_by_title(input_title)
		@@products.find {|each_product| each_product.title == input_title}
	end

	def self.in_stock
		in_stock_array = @@products.select {| each_product | each_product.in_stock?}
	end

private

	# Adding to product array depending on the title check
	def add_to_product
		if product_title_exists?(@title)
			handle_dup_prod_err(@title)
		else
			@@products << self
		end
	end

	# Method to check if title exists to return boolean
	# Seems like class method can be invoked from instance and the search coding is the same which I wish to use
	def product_title_exists?(input_title)
		title_exists = self.class.find_by_title(input_title) ? true : false		
	end

	# Extra feature to handle the exception and show meaningful message
	def handle_dup_prod_err(input_title)
		begin
			raise DuplicateProductError
		rescue Exception => e
			puts e.message + ": '#{input_title}' already exists"
		end
	end

end