class AddDateToSensorValue < ActiveRecord::Migration
  def change
    add_column :sensor_values, :date, :datetime
  end
end
