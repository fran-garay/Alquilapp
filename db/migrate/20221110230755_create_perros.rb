class CreatePerros < ActiveRecord::Migration[7.0]
  def change
    create_table :perros do |t|

      t.timestamps
    end
  end
end
