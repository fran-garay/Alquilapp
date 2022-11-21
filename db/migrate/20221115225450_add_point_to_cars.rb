class AddPointToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :autos, :location_point, :point, geographic: true

  end
end
