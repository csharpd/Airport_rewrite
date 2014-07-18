require 'airport'

describe Airport do

  let(:airport)            {Airport.new                  }
  let(:airport_with_plane) {Airport.new(planes: [:plane])}
  let(:full_airport)       {Airport.new(capacity: 3, planes: [:plane,:plane,:plane])}
  let(:plane)              {double :plane                }
  let(:flying_plane)       {double :plane, land!: :plane }
  let(:grounded_plane)     {double :plane, takeoff!: :plane}


  before (:each) do
    allow(airport).to receive(:stormy?).and_return(false)
    allow(airport_with_plane).to receive(:stormy?).and_return(false)
  end

  context 'creating an airport' do
    it "doesn't contain planes when created" do
      expect(airport).not_to have_planes
    end

    it "can contain planes" do
      expect(airport_with_plane).to have_planes
    end
  end

  context 'capacity' do
    it "will initialise with a default capacity of 100" do
      expect((airport).capacity).to eq 100
    end

    it "can have any size capacity " do
      sydney = Airport.new(capacity: 50)
      expect(sydney.capacity).to eq 50
    end

    it 'isnt full at start' do
      expect(airport).not_to be_full
    end

    it 'knows when it is full' do
      expect(full_airport).to be_full
    end

    it 'a plane cannot land if the airport is full' do
      allow(full_airport).to receive(:stormy?).and_return(false)
      allow(plane).to receive(:land!).and_return(:plane)
      expect(STDOUT).to receive(:puts).with("Sorry - this Airport is full!")
    full_airport.clear_for_landing(plane)
    end
  end

  context 'landing' do
    it 'can clear a plane for landing' do
      plane = double :plane
      expect(plane).to receive(:land!)
      airport.clear_for_landing(plane)
    end

    it 'has planes after a plane landed' do
      plane = double :plane #why can't i delete this?
      expect(plane).to receive(:land!).and_return(:plane)
      airport.clear_for_landing(plane)
      expect(airport).to have_planes
    end
  end

  context 'taking off' do

    it 'can clear a plane for takeoff' do
      grounded_plane = double :plane, takeoff!: :plane
      expect(grounded_plane).to receive(:take_off!)
      airport.clear_for_takeoff(grounded_plane)
    end

    it 'doesnt have any planes after it has taken off' do
      plane = double :plane
      allow(plane).to receive(:take_off!).and_return(:plane)
      airport_with_plane.clear_for_takeoff(plane)
      expect(airport_with_plane).not_to have_planes
    end
  end

  context 'Weather Conditions' do
    before (:each) do
      allow(airport).to receive(:stormy?).and_return(true)
    end

    it 'the plane cant land if it is too stormy' do
      expect(STDOUT).to receive(:puts).with("Sorry - too stormy to land!")
      airport.clear_for_landing(flying_plane)
    end

    it 'the plane cant take off if it is stormy' do
      allow(grounded_plane).to receive(:take_off!).and_return(:plane)
      expect(STDOUT).to receive(:puts).with("Sorry - it's too stormy to takeoff!")
      airport.clear_for_takeoff(grounded_plane)
    end
  end
end







