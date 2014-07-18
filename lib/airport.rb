require_relative 'weather'

class Airport
  include Weather
  attr_reader :capacity, :planes

  DEFAULT_CAPACITY = 100

  def initialize(options = {})
    @planes = options.fetch(:planes, [])
    @capacity = options.fetch(:capacity,DEFAULT_CAPACITY)
  end

  def has_planes?
    planes.any?
  end

  def full?
    planes.count == capacity
  end

  def clear_for_landing(plane)
    return puts "Sorry - too stormy to land!" if stormy?
    return puts "Sorry - this Airport is full!" if full?
    @planes << plane.land!
  end

  def clear_for_takeoff(plane)
    return puts  "Sorry - it's too stormy to takeoff!" if stormy?
    planes.delete(plane.take_off!)
  end

  def receive_all(planes_in_sky)
      until planes_in_sky.all?{ |plane| planes.include?(plane) } do
        planes_in_sky.each do |plane|
          plane.land_at self
        end
      end
  end

  def release_all_planes
    while has_planes? do
        planes.each{|plane| clear_for_takeoff(plane)}
    end
  end

end