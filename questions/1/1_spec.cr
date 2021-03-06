require "spec"
require "./solver_1.cr"

require "../../ilm/measure.cr"
require "../../ilm/quantity.cr"

describe Solver1 do
  settings = [
    {
      measure: Measure::PLANKS_CONSTANT,
      quantity: Quantity::MOMENT_OF_INERTIA,
      operation: :ratio,
      answer: (Quantity::FREQUENCY).dimension
    },

    {
      measure: Measure::GRAVITATIONAL_CONSTANT,
      quantity: Quantity::DENSITY,
      operation: :product,
      answer: (Quantity::ANGULAR_ACCELERATION).dimension
    },

    {
      measure: Measure::ELECTRON_MASS,
      quantity: Quantity::FORCE,
      operation: :ratio,
      answer: (Quantity::NIL / Quantity::ACCELERATION).dimension
    },

    {
      measure: Measure::PI,
      quantity: Quantity::AREA,
      operation: :ratio,
      answer: (Quantity::NIL / Quantity::AREA).dimension
    },
  ]

  settings.each do |setting|
    Scenario1.new(
      measure: setting[:measure],
      quantity: setting[:quantity],
      operation: setting[:operation],
      answer: setting[:answer],
    ).test
  end
end

class Scenario1
  property measure, quantity, operation, answer

  def initialize(
    @measure : Measure,
    @quantity : Quantity,
    @operation : Symbol,
    @answer : Dimension
  );end

  def test
    it "should be #{answer.to_s} "\
       "if measure is #{measure.to_s}, quantity is #{quantity.to_s} and "\
       "operation is #{operation.to_s}" do
      calculated_answer = Solver1
                            .new(
                              measure: measure,
                              quantity: quantity,
                              operation: operation
                            ).solve

      calculated_answer.should eq(answer)
    end
  end
end
