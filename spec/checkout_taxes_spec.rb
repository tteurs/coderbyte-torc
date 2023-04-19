# checkout_taxes_spec.rb
require './checkout_taxes.rb'

RSpec.describe CheckoutTaxes do
  describe "#initialize" do
    it "creates a new item with the given name, price, and imported status" do
      item = CheckoutTaxes.new("book", 1, 12.49, false, false)
      expect(item.name).to eq "book"
      expect(item.price).to eq 12.49
      expect(item.imported).to eq false
    end
  end

  describe "#sales_tax" do
    it "returns the correct sales tax amount for a non-exempt item" do
      item = CheckoutTaxes.new("music CD", 1, 14.99, false, false)
      expect(item.sales_tax).to eq 1.50
    end

    it "returns zero for an exempt item" do
      item = CheckoutTaxes.new("book", 1, 12.49, true, false)
      expect(item.sales_tax).to eq 0.00
    end

    it "returns the correct sales tax amount for an imported item" do
      item = CheckoutTaxes.new("imported bottle of perfume", 1, 47.50, false, true)
      expect(item.sales_tax).to eq 7.15
    end
  end

  describe "#total_price" do
    it "returns the correct total price for an item including sales tax" do
      item = CheckoutTaxes.new("music CD", 1 , 14.99, false, false)
      expect(item.total_price).to eq 16.49
    end
  end
end