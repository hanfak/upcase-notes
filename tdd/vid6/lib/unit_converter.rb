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
      liter: {
        cup: 4.226775,
        liter: 1,
        pint: 2.11338
      },
      gram: {
        gram: 1,
        kilogram: 1000
      }
    }

    def find_conversion_index(from: , to: )
      dimension = common_dimension(from, to) || raise(DimensionalMismatchError)
      CONVERSION_INDEX[dimension][to] / CONVERSION_INDEX[dimension][from]
    end

    def common_dimension(from, to)
      CONVERSION_INDEX.keys.find do |canonical_unit|
        CONVERSION_INDEX[canonical_unit].keys.include?(to) && CONVERSION_INDEX[canonical_unit].keys.include?(from)
      end
    end
end
