class CombineItemsInCart < ActiveRecord::Migration
  def self.up
	# replace multiple items for a single product in a cart with a single item
	# wenn in einem cart das gleiche Produkt mehrmals vorkommt, soll es zu "3x Product1" zusammengefasst werden
	Cart.all.each do |cart|
		# count the number of each product in the cart
		sums = cart.line_items.group(:product_id).sum(:quantity)
		sums.each do |product_id, quantity|
			if quantity > 1
				# remove individual items
				cart.line_items.where(:product_id=>product_id).delete_all
				# replace with a single item
				cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
			end
		end
	end
  end
  

  def self.down
	# split items with quantity>1 into multiple items
	# damit wirs auch wieder rückgängig machen können, aus "3x Product1" wieder 3 Zeilen machen!
	LineItem.where("quantity>1").each do |line_item|
	# add individual items
		line_item.quantity.times do
			LineItem.create :cart_id=>line_item.cart_id, :product_id=>line_item.product_id, :quantity=>1
		end
		# remove original item
		line_item.destroy
	end
  end

end
