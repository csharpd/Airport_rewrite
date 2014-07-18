require 'airport'
require 'plane'


 describe "The grand finale (last spec)" do
   it 'all planes can land' do
      allow(STDOUT).to receive(:puts)
      gatwick = Airport.new(capacity: 100)
      planes_in_sky = []
      100.times{ planes_in_sky << Plane.new}
      gatwick.(planes_in_sky)
      planes_in_sky.each do |plane|
       expect(plane).not_to be_flying
      end
  end

  it 'all planes can takeoff' do
    allow(STDOUT).to receive(:puts)
    planes_on_ground = []
    100.times{ planes_on_ground << Plane.new.land!}
    heathrow = Airport.new(planes: planes_on_ground)
    heathrow.release_all_planes
    expect(heathrow).not_to have_planes
  end
end

#if you wanted to test whether the planes released now have @flying = true you would have to create individual objects and asign them to a variable. Then you could recall to test them.
