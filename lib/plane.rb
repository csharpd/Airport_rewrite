require_relative 'weather'

class Plane
  attr_reader :nickname

  def initialize(options={})
    @nickname = options.fetch(:nickname, random_nick_name)
    @flying = options.fetch(:flying, true)
  end

  def flying?
    @flying
  end

  def land!
    @flying = false
    self
  end

  def take_off!
    @flying = true
    self
    #this self enables me to method chain i.e fighterjet = Plane.new.land!
  end

  def land_at(airport)
    return puts "plane is already on the ground" if !flying?
    airport.clear_for_landing(self)
  end

  def take_off_from(airport)
    return puts "plane is already flying!" if flying?
    airport.clear_for_takeoff(self)
    take_off!
  end

  def random_nick_name
       %w[Bamboo
         Banjo
         Bantam
         Bat
         Nighthawk
         Beast
         Bird
         Blackfish
         Boomerang].sample
  end

end