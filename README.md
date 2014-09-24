#Airport Control

>The planes can land and take off provided that the weather is sunny. Occasionally it may be stormy, in which case no planes can land or take off.

## Technologies used
* Ruby 2.1.2
* RSpec 3.0

### How to run it
```sh
git clone https://github.com/csharpd/Airport_rewrite.git
cd 3_traffic_control
bundle
irb
require './run.rb'
```

Create new objects

```ruby
plane = Plane.new
airport = Airport.new
```

### How to run the tests
```sh
cd 3_traffic_control
rspec
```