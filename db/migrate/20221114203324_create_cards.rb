class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :cvv
      t.bigint :number
      t.string :date
      t.string :name

      t.timestamps
    end
  end
end
