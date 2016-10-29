class SensorValuesController < ApplicationController
  #before_action :set_region, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /regions
  # GET /regions.json
  def index
    @sensor_values = SensorValue.all.includes(:sensor)
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  def register
    data = sensor_params
    @region = Region.find_by_name(data[:region_name])
    @sensor = Sensor.find_by_name(data[:sensor_name])
    
    if not @region
      @region = Region.new
      @region.name = data[:region_name]
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
    @sensorvalue.date = Date.parse(data[:date])
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