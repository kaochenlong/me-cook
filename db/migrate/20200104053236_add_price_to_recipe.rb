class AddPriceToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :price, :integer
  end
end
