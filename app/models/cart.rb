class Cart
  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    found_item = @items.find { |item| item.product_id == product_id }

    if found_item
      found_item.increment!
    else
      @items << CartItem.new(product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def items
    @items
  end

  def total_price
    @items.reduce(0) { |sum, item| sum + item.total_price }
  end

  def serialize
    { 
      "items" => @items.map { |item| 
        { "product_id" => item.product_id, "quantity" => item.quantity }
      } 
    }
  end

  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end
end

