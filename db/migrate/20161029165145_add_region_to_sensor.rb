class AddRegionToSensor < ActiveRecord::Migration
  def change
    add_reference :sensors, :region, index: true, foreign_key: true
  end
end
