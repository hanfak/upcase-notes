
describe UnitConverter do
  describe "#convert" do
    it "translates between objects of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :liter)

      result = converter.convert

      expect(result.amount).to be_within(0.001).of(0.473176)
      expect(result.unit).to eq(:liter)

    end

    it "raises an error if the objects are of differing dimensions" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :grams)

      expect { converter.convert }.to raise_error(DimensionalMismatchError)
    end
  end
end
