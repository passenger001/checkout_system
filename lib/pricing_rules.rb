require 'empty_cart_error'
class PricingRules

  def get_total(cart = {})
    raise EmptyCartError if cart.empty?
    final_total = 0
    cart.each { |item, quantity| final_total += item.price * quantity }
    final_total.round(2)
  end
end

class OpeningDayRules < PricingRules

  def get_total(cart = {})
    raise EmptyCartError if cart.empty?
    final_total = 0
    connector_offer = false
    cart.each do |item, quantity|
      offer_price = item.price
      offer_quantity = quantity
      case item.sku
        when 'atv'
          offer_quantity = (quantity - (quantity/3)) if quantity >= 3
        when 'ipd'
          offer_price = 499.99 if quantity >= 4
        when 'mbp'
          if connector_offer
            offer_price = item.price - connector_offer
          else
            connector_offer = quantity
          end
        when 'vga'
          if connector_offer
            offer_quantity = quantity - connector_offer
            connector_offer = false
          else
            connector_offer = offer_price
          end
        else
          # Do nothing
      end
      final_total += offer_price * offer_quantity
    end
    final_total.round(2)
  end
end

