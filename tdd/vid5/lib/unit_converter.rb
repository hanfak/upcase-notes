DimensionalMismatchError = Class.new(StandardError)

# struct, creates a class with getter and setters
Quantity = Struct.new(:amount, :unit)

class UnitConverter
  def initialize(initial_quantity, target_unit)
    @initial_quantity = initial_quantity
    @target_unit = target_unit
  end

  def convert
    Quantity.new(
      @initial_quantity.amount * find_conversion_index(from: @initial_quantity.unit, to: @target_unit),
      @target_unit
    )
  end

  private

    CONVERSION_INDEX = {
      cup: {
        liter: 0.236588
      }
    }

    def find_conversion_index(from: , to: )
      CONVERSION_INDEX[from][to] || raise(DimensionalMismatchError)
    end
end
