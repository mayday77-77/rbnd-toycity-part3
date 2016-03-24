require_relative "transaction"

class Customer

	attr_accessor :name

	@@customers = []

	def initialize(options = {})
		@name = options[:name]
		add_to_customers
	end

	# not sure if this is correct in terms of the self argument, but it is working
	def purchase(product)
		new_purchase = Transaction.new(self, product)
	end

	def self.all
		@@customers
	end

	def self.find_by_name(input_name)
		@@customers.each do | each_customer |
			if each_customer.name == input_name
				return each_customer
			end
		end
	end

private

	# Adding to customer array depending on the name check
	def add_to_customers
		if cust_name_exists?(@name)
			begin
				raise DuplicateCustomerError
			rescue Exception => e
				puts e.message + ": '#{@name}' already exists"
			end
		else
			@@customers << self
		end
	end

	# Method to check if name exists in the customers array and return boolean
	def cust_name_exists?(input_name)
		@@customers.each do | each_customer |
			return true if each_customer.name == input_name; end
		return false					
	end

end