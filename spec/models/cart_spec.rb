require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(2)
      expect(cart.empty?).to be false
    end

    it "相同商品，CartItem 不會增加，商品數量會改變" do
      cart = Cart.new

      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      2.times { cart.add_item(3) }
      5.times { cart.add_item(2) }

      expect(cart.items.count).to be 3
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new
      r1 = create(:recipe)
      r2 = create(:recipe)

      3.times { cart.add_item(r1.id) }
      2.times { cart.add_item(r2.id) }

      expect(cart.items.first.product).to be_a Recipe
    end
    
    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
      cart = Cart.new
      r1 = create(:recipe, price: 10)
      r2 = create(:recipe, price: 20)

      3.times { cart.add_item(r1.id) }
      2.times { cart.add_item(r2.id) }

      expect(cart.items.first.total_price).to be 30
      expect(cart.items.last.total_price).to be 40
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      r1 = create(:recipe, price: 10)
      r2 = create(:recipe, price: 20)

      3.times { cart.add_item(r1.id) }
      2.times { cart.add_item(r2.id) }

      expect(cart.total_price).to be 70
    end
  end

  context "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do
      cart = Cart.new
      r1 = create(:recipe)
      r2 = create(:recipe)

      3.times { cart.add_item(r1.id) }
      2.times { cart.add_item(r2.id) }

      expect(cart.serialize).to eq cart_hash
    end

    it "存放在 Session 的內容（Hash 格式），還原成購物車的內容。" do
      # Arrange / Act
      cart = Cart.from_hash(cart_hash)

      # Assert
      expect(cart.items.count).to be 2
      expect(cart.items.first.product_id).to be 1
    end
  end

  private

  def cart_hash
    {
      "items" => [
        { "product_id" => 1, "quantity" => 3}, 
        { "product_id" => 2, "quantity" => 2}, 
      ]
    }
  end
end

# 
# 
