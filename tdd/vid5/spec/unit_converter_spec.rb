
describe UnitConverter do
  describe "#convert" do
    it "translates between objects of the same dimension" do
      converter = UnitConverter.new(2, :cup, :liter)

      expect(converter.convert).to be_within(0.001).of(0.473176)
    end

    it "raises an error if the objects are of differing dimensions" do
      converter = UnitConverter.new(2, :cup, :grams)

      expect { converter.convert }.to raise_error(DimensionalMismatchError)
    end
  end
end
