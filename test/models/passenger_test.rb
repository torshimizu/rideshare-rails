require "test_helper"

describe Passenger do
  let(:passenger) { Passenger.new }

  it "must be valid" do
    value(passenger).must_be :valid?
  end
end
