class Product

	attr_reader :title, :price, :stock

	@@products = []

	def initialize(options = {})
		@title = options[:title]
		add_to_product
	end

	def self.all
		@@products
	end

private

	def add_to_product
		duplicate = 0
		@@products.each do | each_product |
			if each_product.title == @title
				duplicate = 1
				break
			end
		end

		if duplicate == 0
			@@products << self
		else
			raise DuplicateProductError, "#{@title} already exists"
		end

	end

end