require 'rspec'
require 'checkout'
require 'pricing_rules'
require 'product'

describe 'Checkout' do
  before do
    @pricing_rules = PricingRules.new
    @co = Checkout.new(@pricing_rules)
  end
  describe '#new' do

    context 'when a new checkout object is initialized' do

      it 'assigns the pricing_rules parameter as its attribute' do
        expect(@co.pricing_rules).to eq @pricing_rules
      end

      it 'creates a cart' do
        expect(@co.cart.class).to eq Hash
      end
    end
  end

  describe '#scan' do
    context 'when items are scanned' do
      before do
        @atv = Product.new('atv', 'atv', 109.50)
        @vga = Product.new('vga', 'vga', 30.00)
        @co.scan(@atv)
        @co.scan(@vga)
      end

      it 'stores them in the cart' do
        expect(@co.cart.count).to eq 2
      end

      it 'saves the item and quantity as a hash in the cart' do
        expect(@co.cart[@atv]).to eq 1
      end
    end

    context 'when same items are scanned' do
      before do
        @atv = Product.new('atv', 'atv', 109.50)
        @co.scan(@atv)
        @co.scan(@atv)
        @co.scan(@atv)
      end
      it 'appends the value of the item in the cart' do
        expect(@co.cart[@atv]).to eq 3
      end
    end
  end

  describe '#total' do
    before do
      allow(@pricing_rules).to receive(:get_total) { 99.99 }
    end
    it 'returns the value fetched from get_total method of pricing rules' do
      expect(@co.total).to eq '$99.99'
    end
  end
end
