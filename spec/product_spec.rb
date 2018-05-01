require 'rspec'
require 'product'

describe 'Product' do
  describe '#new' do
    context 'when sku, product name and price are given to initialize'

    before do
      @product = Product.new('sku', 'name', 99.99)
    end

    it 'assigns sku parameter as its attribute' do
      expect(@product.sku).to eq 'sku'
    end

    it 'assigns name parameter as its attribute' do
      expect(@product.name).to eq 'name'
    end

    it 'assigns price parameter as its attribute' do
      expect(@product.price).to eq 99.99
    end
  end
end
