class CheckoutTaxes
  attr_reader :name, :quantity, :price, :exempt, :imported

  def initialize(name, quantity, price, exempt, imported)
    @name = name
    @quantity = quantity.to_i
    @price = price.to_f
    @exempt = exempt
    @imported = imported
  end

  def tax_rate
    tax_rate = 0.1
    tax_rate += 0.05 if imported
    tax_rate
  end

  def sales_tax
    exempt ? 0 : ((price * tax_rate) * 20).ceil / 20.0
  end

  def import_tax
    imported ? ((price * 0.05) * 20).ceil / 20.0 : 0
  end

  def total_price
    ((price + sales_tax + import_tax) * quantity).round(2)
  end

  def to_s
    "#{quantity} #{name}: #{'%.2f' % total_price}"
  end
end

class Receipt
  def initialize(items)
    @items = items
  end

  def print_receipt
    total_sales_tax = @items.sum(&:sales_tax)
    total_price = @items.sum(&:total_price)

    @items.each { |item| puts item.to_s }

    puts "Sales Taxes: #{'%.2f' % total_sales_tax}"
    puts "Total: #{'%.2f' % total_price}"
  end
end

def parse_input(input)
  input.split("\n").map do |line|
    match = /(\d+) (.+) at (\d+\.\d{2})/.match(line)
    exempt = %w[book food medical].any? { |word| match[2].include?(word) }
    imported = match[2].include?("imported")
    CheckoutTaxes.new(match[2], match[1], match[3], exempt, imported)
  end
end

input = <<~EOS
  2 book at 12.49
  1 music CD at 14.99
  1 chocolate bar at 0.85
EOS

# puts "input was:
# #{input}"
items = parse_input(input)
receipt = Receipt.new(items)
#puts "output was:"
receipt.print_receipt