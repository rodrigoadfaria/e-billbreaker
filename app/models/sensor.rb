class Sensor < ActiveRecord::Base
    has_many :sensor_value
    belongs_to :region
end
