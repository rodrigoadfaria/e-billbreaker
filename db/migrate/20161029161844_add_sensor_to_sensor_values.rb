class AddSensorToSensorValues < ActiveRecord::Migration
  def change
    add_reference :sensor_values, :sensor, index: true, foreign_key: true
  end
end
