require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'


class StatewideTestingTest < Minitest::Test

  def setup

  end

  def test_proficient_by_grade_method_returns_a_hash_with_proper_data
    skip
    expected = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
       2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
       2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
       2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
       2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
       2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
       2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
    }

    assert_equal expected, @statewide_testing.proficient_by_grade(3)

    assert_raises UnknownDataError do
      @statewide_testing.proficient_by_grade(111)
    end
  end

  def test_proficient_by_grade_method_raises_an_error_with_an_unknown_grade
    skip

  end



end
