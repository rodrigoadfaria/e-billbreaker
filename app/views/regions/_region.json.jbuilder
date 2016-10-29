json.extract! region, :id, :name, :lat, :lng, :created_at, :updated_at
json.url region_url(region, format: :json)