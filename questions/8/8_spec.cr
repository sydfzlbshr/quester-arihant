require "spec"
require "./solver_8.cr"

require "../../ilm/measure.cr"
require "../../ilm/dimension.cr"
require "../../ilm/quantity.cr"

describe Solver8 do
  settings = [
    {

      measure_1: Measure::STEFAN_CONSTANT,
      measure_2: Measure::WEIN_CONSTANT,
      answer: Dimension.from_s("M1L4T-3")
    }
  ]

  settings.each do |setting|
    Scenario8.new(
      measure_1: setting[:measure_1],
      measure_2: setting[:measure_2],
      answer: setting[:answer],
    ).test
  end
end

class Scenario8
  property measure_1, measure_2, answer

  def initialize(
    @measure_1 : Measure,
    @measure_2 : Measure,
    @answer : Dimension
  );end

  def test
    it "should be #{answer.to_s} " do
      calculated_answer = Solver8
                            .new(
                              measure_1: measure_1,
                              measure_2: measure_2
                            ).solve

      calculated_answer.should eq(answer)
    end
  end
end
