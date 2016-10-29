class CreateSensorValues < ActiveRecord::Migration
  def change
    create_table :sensor_values do |t|
      t.float :value

      t.timestamps null: false
    end
  end
end
