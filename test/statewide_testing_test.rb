require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'
require './lib/district_repository'

class StatewideTestingTest < Minitest::Test

  def setup
    repository  = StatewideTestingTest.make_district_repository
    @district   = repository.find_by_name("ACADEMY 20")
  end

  def self.make_district_repository
    repository  ||= DistrictRepository.from_csv(File.expand_path("../data", __dir__))
  end

  def test_proficient_for_subject_by_grade_method_takes_valid_three_parameter
    skip
    # should take in grade as an integer from the set: [3, 8]
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
  end

  def test_proficient_by_grade_method_raises_an_error_with_an_unknown_grade
    skip
    assert_raises UnknownDataError do
      @statewide_testing.proficient_by_grade(111)
    end
  end

  def test_proficient_by_race_or_ethnicity_method_takes_valid_parameter
    skip
    # should take in race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  end

  def test_proficient_by_race_or_ethnicity_method_raises_an_error_with_an_unknown_race
    skip
    assert_raises UnknownDataError do
      @statewide_testing.proficient_by_race_or_ethinicity(:indian)
    end
  end

  def test_proficient_by_race_or_ethnicity_method_returns_a_hash_with_proper_data
    skip
    expected = { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
                 2012 => {math: 0.818, reading: 0.893, writing: 0.808},
                 2013 => {math: 0.805, reading: 0.901, writing: 0.810},
                 2014 => {math: 0.800, reading: 0.855, writing: 0.789},
               }

   assert_equal expected, @statewide_testing.proficient_by_race_or_ethinicity(:asian)
  end

  def test_proficient_for_subject_by_grade_in_year_method_takes_valid_three_parameters
    skip
    # should take in subject as a symbol from: [:math, :reading, :writing]
    # grade as an integer from: [3, 8]
    # year as an integer
  end

  def test_proficient_for_subject_by_grade_in_year_method_raises_an_error_with_any_invalid_parameter
    skip
    assert_raises UnknownDataError do
      @statewide_testing.proficient_for_subject_by_grade_in_year(:science, 8, 2011)
    end

    assert_raises UnknownDataError do
      @statewide_testing.proficient_for_subject_by_grade_in_year(:math, 12, 2011)
    end
  end

  def test_proficient_for_subject_by_grade_in_year_method_returns_truncated_three_digit_percentage_float
    skip
    expected = 0.857

    assert_equal expected, @statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_proficient_for_subject_by_race_in_year_method_takes_valid_three_parameters
    skip
    # should take in subject as a symbol from: [:math, :reading, :writing]
    # race as a symbol from: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # year as an integer
  end

  def test_proficient_for_subject_by_race_in_year_method_raises_an_error_with_any_invalid_parameter
    skip
    assert_raises UnknownDataError do
      @statewide_testing.proficient_for_subject_by_race_in_year(:history, :asian, 2010)
    end

    assert_raises UnknownDataError do
      @statewide_testing.proficient_for_subject_by_race_in_year(:writing, :japanese, 2010)
    end
  end

  def test_proficient_for_subject_by_race_in_year_method_returns_truncated_three_digit_percentage_float
    skip
    expected = 0.818

    assert_equal expected, @statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
  end

  def test_proficient_for_subject_in_year_method_takes_valid_two_parameters
    skip
    # should take in subject as a symbol from: [:math, :reading, :writing]
    # year as an integer
  end

  def test_proficient_for_subject_in_year_method_raises_an_error_with_any_invalid_parameter
    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_in_year(:history, 2012)
    end

    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_in_year(:math, 1842)
    end
  end

  def test_proficient_for_subject_in_year_method_returns_truncated_three_digit_percentage_float
    assert_equal 0.689, @district.statewide_testing.proficient_for_subject_in_year(:math, 2012)
  end

end
