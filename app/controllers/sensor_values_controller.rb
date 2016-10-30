class SensorValuesController < ApplicationController
  #before_action :set_region, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /regions
  # GET /regions.json
  def index
    zoom = params['zoom']
    number_of_entries = session['number_of_entries'] || 300
    if zoom
      if zoom == 'in'
        number_of_entries -= 100
      else
        number_of_entries += 100
      end
    end

    # we are using at least 300 entries as default
    if number_of_entries < 300
      number_of_entries = 300
    end
    session['number_of_entries'] = number_of_entries

    @sensor_values = SensorValue.all.includes(:sensor)
                                    .order(:date)
                                    .last(number_of_entries)
    
    resources = {}
    @sensor_values.each do |data|
      resource = resources[data.sensor.name] || {}
      
      resource['sensor_name'] = data.sensor.name
      resource['lat'] = data.sensor.region.lat
      resource['lng'] = data.sensor.region.lng
      
      value = {}
      value['value'] = data.value
      value['date'] = data.date

      values = resource['values'] || []
      values << value
      resource['values'] = values

      resources[data.sensor.name] = resource
    end
    
    render json: { resources: resources.values }
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  def charts
  end

  def register
    data = sensor_params
    @region = Region.find_by_name(data[:region_name])
    @sensor = Sensor.find_by_name(data[:sensor_name])
    
    if not @region
      @region = Region.new
      @region.name = data[:region_name]
      @region.lat = data[:region_lat]
      @region.lng = data[:region_lng]
      @region.save # adding save here
    end
    
    if not @sensor
      @sensor = Sensor.new
      @sensor.name = data[:sensor_name]
      @sensor.save # adding save here
    end 
    
    @sensor.region = @region
    @sensor.save
    
    
    @sensorvalue = SensorValue.new
    @sensorvalue.value = data[:value]
    @sensorvalue.date = DateTime.parse(data[:date])
    @sensorvalue.sensor = @sensor
    @sensorvalue.save # adding save here    
    
    
    render json: { status: :ok }
  end

  # GET /regions/new
  def new
    @sensor_value = SensorValue.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor_value).permit(:value, :sensor_name, :region_name,
                                           :region_lat, :region_lng, :date)
    end
end