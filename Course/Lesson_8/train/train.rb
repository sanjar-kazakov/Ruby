require_relative 'company'
require_relative '../helpers/instance_counter'
require_relative '../helpers/validation'

# Train class
class Train
  include Company
  include InstanceCounter
  include Validation

  attr_accessor :speed, :type, :number, :current_station_num, :carriages, :route

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  def self.trains
    @trains = []
  end

  def self.find(train_number)
    @trains[train_number] # .detect { |train| train.number == train_number }
  end

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
    validate!
    self.class.trains << self
    register_instance
  end

  def accelerate
    @speed += 10
  end

  def brake
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current_station_num = 0
    current_station
  end

  def previous_station
    route.route_stations[@current_station_num - 1] unless @route.nil?
  end

  def current_station
    route.route_stations[@current_station_num]
  end

  def next_station
    route.route_stations[@current_station_num + 1] unless @route.nil?
    # require 'pry'; binding.pry
  end

  def move_forward
    @current_station_num += 1 if next_station
  end

  def move_backward
    @current_station_num -= 1 if previous_station
  end

  def add_carriage(carriage)
    @carriages << carriage if @speed.zero?
  end

  def remove_carriage
    @carriages.delete_at(-1) if @speed.zero?
  end

  def each_carriage(&block)
    @carriages.each { |carr| block.call(carr) }
  end
end
