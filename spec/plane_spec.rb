
require 'plane'

describe Plane do

  let(:plane)               {Plane.new}

  context 'upon initialising a plane' do
    it 'should be able to provide a a nick_name'  do
      expect(Plane.new(nickname: 'Bomber').nickname).to eq 'Bomber'
    end

    it 'should be flying' do
      expect(plane).to be_flying
    end
  end

  context 'Landing:' do
    it 'should be able to land at an airport' do
      gatwick = double :airport
      expect(gatwick).to receive(:clear_for_landing)
      plane.land_at(gatwick)
    end

    it 'after landing should not be flying' do
      plane.land!
      expect(plane).not_to be_flying
    end

    it 'planes already on the ground shouldnt be able to land' do
      fighterjet = Plane.new.land!
      gatwick = double :airport, clear_for_landing: :plane
      expect(STDOUT).to receive(:puts).with("plane is already on the ground")
      fighterjet.land_at(gatwick)
    end

  end

  context 'taking off' do
    it 'should be able to take off from an airport' do
      fighterjet = Plane.new.land!
      heathrow = double :airport, planes: [fighterjet]
      expect(heathrow).to receive(:clear_for_takeoff).with(fighterjet)
      fighterjet.take_off_from(heathrow)
    end

    it ' after taking off, should be flying' do
      heathrow = double :airport, clear_for_takeoff: :plane
      fighterjet = Plane.new.land!
      fighterjet.take_off_from(heathrow)
      expect(fighterjet).to be_flying
    end

    it 'planes already flying shouldnt be able to take off' do
       heathrow = double :airport, clear_for_takeoff: :plane
       expect(STDOUT).to receive(:puts).with("plane is already flying!")
       plane.take_off_from(heathrow)
     end
  end


end