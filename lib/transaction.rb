class Transaction

	attr_accessor :id, :customer, :product

	@@transactions = []

	def initialize(customer, product)
		handle_product_stock(customer, product)
	end

	def self.all
		@@transactions
	end

	# Using enumerable method find to see if product exists
	def self.find(purchase_id)
		@@transactions.find {| each_transaction | each_transaction.id == purchase_id}
	end

private
	
	# Add the transaction
	def add_transaction(customer, product)
		@id = @@transactions.count + 1
		@customer = customer
		@product = product
		@@transactions << self
	end

	# To check the stock and reduce by 1 if > 0 
	# And add into transaction array only if above is true
	def handle_product_stock(customer, product)
		if product.in_stock?
			product.reduce_stock_count
			add_transaction(customer, product)
		else
			handle_no_stock_err(product.title)
		end
	end

	# Extra feature to handle the exception and show meaningful message
	def handle_no_stock_err(input_title)
		begin
			raise OutOfStockError
		rescue Exception => e
			puts e.message + ": '#{input_title}' is out of stock"
		end
	end

end