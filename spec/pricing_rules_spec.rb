require 'rspec'
require 'pricing_rules'
require 'checkout'
require 'product'

describe 'PricingRules' do
  before do
    @pricing_rules = PricingRules.new
    @co = Checkout.new(@pricing_rules)
    @atv = Product.new('atv', 'atv', 109.50)
    @vga = Product.new('vga', 'vga', 30.00)
    @cart = { @atv => 1, @vga => 2 }
  end

  describe '#get_total' do
    context 'when cart parameter is supplied' do
      it 'calculates the total' do
        expect(@pricing_rules.get_total(@cart)).to eq 169.50
      end
    end
    context 'when cart parameter is not supplied' do
      it 'returns EmptyCartError' do
        expect { @pricing_rules.get_total }.to raise_error(EmptyCartError)
      end
    end
  end
end

describe 'OpeningDayRules' do
  before do
    @pricing_rules = OpeningDayRules.new
    @co = Checkout.new(@pricing_rules)
    @atv = Product.new('atv', 'atv', 109.50)
    @vga = Product.new('vga', 'vga', 30.00)
    @ipd = Product.new('ipd', 'ipd', 549.99)
    @mbp = Product.new('mbp', 'mbp', 1399.99)
  end

  describe '#get_total' do

    context 'when cart parameter is supplied' do
      it 'calculates the total' do
        @cart = { @atv => 1, @vga => 2 }
        expect(@pricing_rules.get_total(@cart)).to eq 169.50
      end
    end

    context 'when cart parameter is not supplied' do
      it 'returns EmptyCartError' do
        expect { @pricing_rules.get_total }.to raise_error(EmptyCartError)
      end
    end

    context 'when cart has 3 apple tvs and a vga connector' do
      it 'returns 249.00' do
        @cart = { @atv => 3, @vga => 1 }
        expect(@pricing_rules.get_total(@cart)).to eq 249.00
      end
    end

    context 'when cart has 2 apple tvs and 5 ipads' do
      it 'returns 2718.95' do
        @cart = { @atv => 2, @ipd => 5 }
        expect(@pricing_rules.get_total(@cart)).to eq 2718.95
      end
    end

    context 'when cart has 1 macbookpro, 1 vga and 1 ipad' do
      it 'returns 2718.95' do
        @cart = { @mbp => 1, @vga => 1, @ipd => 1 }
        expect(@pricing_rules.get_total(@cart)).to eq 1949.98
      end
    end

    context 'when cart has 3 vga connectors, 2 macbookpros and 1 ipad' do
      it 'returns 3379.97' do
        @cart = { @vga => 3, @mbp => 2, @ipd => 1 }
        expect(@pricing_rules.get_total(@cart)).to eql 3379.97
      end
    end

  end

end
