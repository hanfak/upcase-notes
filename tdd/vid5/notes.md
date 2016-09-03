Now that we've looked at some small examples using TDD, it's time to jump into a meatier project: building a measurement unit converter.

Getting StartedJump to Topic In Video
To start, we'll pick straightforward examples for UnitConverter#convert: the method will help us convert 2 cups into the correct number of liters (0.473 liters for those of you keeping score at home), and will raise an exception if the requested measurement types don't translate from one to the other. These RSpec tests will help us get to the code we want to have:

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
Sometimes it can make sense to combine two test phases, as we have here. The exercise phase is so straightforward that storing it in a variable what will immediately be verified in the next step isn't necessary.

In the test that verifies the raising of an exception, note that our exercise is wrapped in a block, which allows RSpec to verify against the specific execution of the block's contents.

Attempting to run the spec informs us the class doesn't exist yet, and subsequently that the constructor has the wrong number of arguments. Once those initial failures are fixed, it's time to drill down and focus on a single example.

Isolating An ExampleJump to Topic In Video
Rather than try to solve all the failures at once, it's better to focus on a single test failure, and write the code that makes the spec pass. One way to skip a test is to replace its it invocation with xit, which tells RSpec that the example should be considered pending and shouldn't be run in the suite.

# skip this example
xit "raises an error if the objects are of differing dimensions" do
  converter = UnitConverter.new(2, :cup, :grams)

  expect { converter.convert }.to raise_error(DimensionalMismatchError)
end
Changing the Converter with TestsJump to Topic In Video
The UnitConverter works, but it could be improved if quantities and units were expressed together in a way that made more sense. Ian and Harry want to modify the converter to take a quantity (a data clump combining an amount and a unit) as an argument and to return a quantity. First we'll modify the tests to accommodate the new interface, watch the specs fail, and then we'll update the code to make the specs pass.

Don't Test Private Methods!Jump to Topic In Video
In the UnitConverter specs, there are private methods in the class that aren't directly tested in the suite. This coverage decision is intentional! Private methods are an implementation detail that should be able to change in refactoring without breaking tests. Your public methods should be covered by tests, and the behavior of private methods might be covered by tests of public methods, but your private methods should not be tested directly. Don't use #send to cheat and invoke private methods for test.
