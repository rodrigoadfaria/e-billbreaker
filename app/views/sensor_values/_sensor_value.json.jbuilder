json.extract! sensor_value, :id, :value, :created_at, :updated_at
json.url sensor_value_url(sensor_value, format: :json)