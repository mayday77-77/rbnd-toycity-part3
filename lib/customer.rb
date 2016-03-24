require_relative "transaction"

class Customer

	attr_accessor :name

	@@customers = []

	def initialize(options = {})
		@name = options[:name]
		add_to_customers
	end

	# Method to make a new transaction
	def purchase(product)
		new_purchase = Transaction.new(self, product)
	end

	def self.all
		@@customers
	end

	# Using enumerable method find to see if name exists
	def self.find_by_name(input_name)
		@@customers.find {|each_customer| each_customer.name == input_name}
	end

private

	# Adding to customer array depending on the name check
	def add_to_customers
		if cust_name_exists?(@name)
			handle_dup_cust_error(@name)
		else
			@@customers << self
		end
	end

	# Method to check if name exists in the customers array and return boolean
	# Seems like class method can be invoked from instance and the search coding is the same which I wish to use
	def cust_name_exists?(input_name)
		name_exists = self.class.find_by_name(input_name) ? true : false					
	end

	# Extra feature to handle the exception and show meaningful message
	def handle_dup_cust_error(input_name)
		begin
			raise DuplicateCustomerError
		rescue Exception => e
			puts e.message + ": '#{input_name}' already exists"
		end
	end

end