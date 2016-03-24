class Transaction

	attr_accessor :id, :customer, :product

	@@transactions = []

	def initialize(customer, product)
		@id = @@transactions.count + 1
		@customer = customer
		# Check to see if there is stock for product and reduced by 1
		handle_product_stock(product)
		@product = product
		@@transactions << self	
	end

	def self.all
		@@transactions
	end

	# loop through transaction array and return the object if found
	def self.find(purchase_id)
		@@transactions.each do | each_transaction |
			if each_transaction.id == purchase_id
				return each_transaction
			end
		end
	end

private

	# Need to revisit the logic as transaction will still be added which is wrong
	def handle_product_stock(product)
		if product.in_stock?
			product.reduce_stock_count
		else
			begin
				raise OutOfStockError
			rescue Exception => e
				puts e.message + ": '#{product.title}' is out of stock"
			end
		end
	end

end