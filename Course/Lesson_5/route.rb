require_relative 'instance_counter'

class Route
    include InstanceCounter

    attr_accessor :route_stations

    def initialize(first_station, last_station)
        @route_stations = [first_station, last_station]
        register_instance
    end

    def add_int_station(int_station)
        route_stations.insert(-2, int_station)
    end

    def remove_int_station(int_station)
        if (route_stations.include?(int_station)) && (route_stations.size > 2)
        route_stations.delete(int_station)
        else
        end
    end
end