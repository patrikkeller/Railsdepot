require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "leeres Product kann keine Validations erfuellen" do
	# leeres Produkt erzeugen
	product= Product.new
	# nun Testen: erfüllt dieses leere Produkt alle Validiereungen 
	#(sollte nicht). Das Produkt muesste immernoch invalid (=true) sein,
	# also gibt der Test keinen Fehler, da wir das so erwarten
	assert product.invalid?	
  end
  
  test "product attributes must not be empty" do
    product = Product.new
	assert product.invalid?
	# im zurückgegebenen errors-Vektor müssen die aufgeführten Felder "reklamiert werden: 
	# [:title].any?
	assert product.errors[:title].any?
	assert product.errors[:description].any?
	assert product.errors[:price].any?
	assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
	# was passiert bei unterschiedlichen Preisen?
	product = Product.new(:title => "My Book Title",:description => "yyy",:image_url => "zzz.jpg")
	product.price = -1
	assert product.invalid?
	
	assert_equal "must be greater than or equal to 0.01",
		product.errors[:price].join('; ')
	
	product.price = 0
	assert product.invalid?
	# auch die Fehlermeldung soll dann so sein, wie wir es erwarten!
	assert_equal "must be greater than or equal to 0.01",
		product.errors[:price].join('; ')
	
	product.price = 1
	assert product.valid?
  end
  
  # verschiedene Bild URLs durchtesten
  # als erstes eine Methode der man eine URL übergeben kann und die ein Product erzeugt
  def new_product(image_url)
	Product.new(:title => "My Book Title",:description => "yyy",:price => 1,:image_url => image_url)
  end
  # dann durchtesten
  test "image url" do
	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
		assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
	
	bad.each do |name|
		assert new_product(name).invalid?, "#{name} shouldn't be valid"
	end
  end

  # mit Fixtures testen
  # benutzt das Fixture mit Titel "ruby"
  test "product is not valid without a unique title" do
	product = Product.new(:title => products(:ruby).title,:description => "yyy",:price => 1,:image_url => "fred.gif")
	# :ruby existiert ja schon in der DB und soll nicht nochmal gesp. werden können!
	assert !product.save
	assert_equal "has already been taken", product.errors[:title].join('; ')
  end
  
  # nochmals dasselbe aber nicht gegen den equal String sondern die interne Fehlermeldung verglichen
  test "product is not valid without a unique title - i18n" do
	product = Product.new(:title => products(:ruby).title,:description => "yyy",:price => 1,:image_url => "fred.gif")
	assert !product.save
	assert_equal I18n.translate('activerecord.errors.messages.taken'),
	product.errors[:title].join('; ')
  
  end
