require "test_helper"

describe Trip do
  let(:trip) { Trip.new }

  it "must be valid" do
    value(trip).must_be :valid?
  end
end
