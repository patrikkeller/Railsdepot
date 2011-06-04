class Order < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
	validates :name, :address, :email, :pay_type, :presence => true
	validates :pay_type, :inclusion => PAYMENT_TYPES
	
	# the create action assumes, that the order object contains the method add_line_items_from_cart
	# here it is:
	def add_line_items_from_cart(cart)
		# for each item we transfer from cart to order
		
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end
	
end
