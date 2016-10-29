class SensorValuesController < ApplicationController
  #before_action :set_region, only: [:show, :edit, :update, :destroy]

  # GET /regions
  # GET /regions.json
  def index
    @sensor_values = SensorValue.all.includes(:sensor)
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @sensor_value = SensorValue.new
  end
end