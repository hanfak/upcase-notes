class UnitConverter
  def initialize(amount, initial_unit, target_unit)
    @amount = amount
    @initial_unit = initial_unit
    @target_unit = target_unit
  end

  def convert
    @amount * find_conversion_index(from: @initial_unit, to: @target_unit)
  end

  private

    CONVERSION_INDEX = {
      cup: {
        liter: 0.236588
      }
    }

    def find_conversion_index(from: , to: )
      CONVERSION_INDEX[from][to]
    end
end
