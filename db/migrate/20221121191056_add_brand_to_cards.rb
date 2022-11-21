class AddBrandToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :brand, :string
  end
end
