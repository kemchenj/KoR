class AddProductPriceToLineItems < ActiveRecord::Migration[5.1]
  def up
    add_column :line_items, :product_price, :decimal

    line_items = LineItem.all

    line_items.each do |line_item|
      product = Product.find(line_item.product_id)
      line_item.product_price = product.price

      line_item.save
    end
  end

  def down
    remove_column :line_items, :product_price, :decimal
  end

  def change
  end
end
