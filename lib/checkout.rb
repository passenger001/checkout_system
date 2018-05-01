class Checkout
  attr_accessor :pricing_rules, :cart

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @cart = Hash.new(0)
  end

  def scan(item)
    @cart[item] += 1
  end

  def total
    "$#{@pricing_rules.get_total(@cart)}"
  end
end
