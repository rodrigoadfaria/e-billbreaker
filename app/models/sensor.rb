class Sensor < ActiveRecord::Base
    has_many :sensor_value
end