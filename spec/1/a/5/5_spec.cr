require "spec"
require "./solver_5.cr"

require"../../../../measure.cr"
require"../../../../dimension.cr"
require"../../../../quantity.cr"

describe Solver5 do
  settings = [
    {
      quantity_1: Quantity::ELECTRIC_FIELD ** 2,
      measure_2: Measure::PERMEABILITY_OF_FREE_SPACE,
      answer: Dimension.new(mass: 1, length: 1, time: -4)
    },

    {
      quantity_1: Quantity::MAGNETIC_FLUX,
      measure_2: Measure::ELECTRON_CHARGE,
      answer: Dimension.new(mass: 1, length: 2, time: -3, electric_current: -2)
    }
  ]

  settings.each do |setting|
    Scenario5.new(
      quantity_1: setting[:quantity_1],
      measure_2: setting[:measure_2],
      answer: setting[:answer],
    ).test
  end
end

class Scenario5
  property quantity_1, measure_2, answer

  def initialize(
    @quantity_1 : Quantity,
    @measure_2 : Measure,
    @answer : Dimension
  );end

  def test
    it "should be #{answer.to_s} "\
       "if quantity_1 is #{quantity_1.to_s} and "\
       "measure_2 is #{measure_2.to_s}" do
      calculated_answer = Solver5
                            .new(
                              quantity_1: quantity_1,
                              measure_2: measure_2,
                            ).solve

      calculated_answer.to_s.should eq(answer.to_s)
    end
  end
end