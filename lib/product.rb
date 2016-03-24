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

	# loop through product array and return the object if found
	# Revisit : maybe need to take care if not found?
	# Revisit : maybe try to refine the search, it seems repeated. e.g include?
	def self.find_by_title(input_title)
		@@products.each do | each_product |
			if each_product.title == input_title
				return each_product
			end
		end
	end

	def self.in_stock
		in_stock_array = @@products.select {| each_product | each_product.in_stock?}
	end

#private_class_method :all

private

	# Adding to product array depending on the title check
	def add_to_product
		if product_title_exists?(@title)
			begin
				raise DuplicateProductError
			rescue Exception => e
				puts e.message + ": '#{@title}' already exists"
			end
		else
			@@products << self
		end
	end

	# Method to check if title exists in the products array and return boolean
	def product_title_exists?(input_title)
		@@products.each do | each_product |
			return true if each_product.title == input_title; end
		return false					
	end

end