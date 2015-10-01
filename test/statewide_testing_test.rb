require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'
require './lib/district_repository'

class StatewideTestingTest < Minitest::Test

  def setup
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    @district = repository.find_by_name("ACADEMY 20")
  end

  def test_proficient_by_grade_method_returns_a_hash_with_proper_data
    expected = { 2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671 },
                 2009 => { :math => 0.824, :reading => 0.862, :writing => 0.706 },
                 2010 => { :math => 0.849, :reading => 0.864, :writing => 0.662 },
                 2011 => { :math => 0.819, :reading => 0.867, :writing => 0.678 },
                 2012 => { :math => 0.830, :reading => 0.870, :writing => 0.655 },
                 2013 => { :math => 0.855, :reading => 0.859, :writing => 0.668 },
                 2014 => { :math => 0.834, :reading => 0.831, :writing => 0.639 }
               }

    assert_equal expected, @district.statewide_testing.proficient_by_grade(3)
  end

  def test_proficient_by_grade_method_raises_an_error_with_an_unknown_grade
    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_by_grade(111)
    end
  end

  def test_proficient_by_race_or_ethnicity_method_raises_an_error_with_an_unknown_race
    assert_raises UnknownRaceError do
      @district.statewide_testing.proficient_by_race_or_ethnicity(:indian)
    end
  end

  def test_proficient_by_race_or_ethnicity_method_returns_a_hash_with_proper_data
    expected = { 2011 => { math: 0.816, reading: 0.897, writing: 0.826 },
                 2012 => { math: 0.818, reading: 0.893, writing: 0.808 },
                 2013 => { math: 0.805, reading: 0.901, writing: 0.810 },
                 2014 => { math: 0.800, reading: 0.855, writing: 0.789 },
               }

   assert_equal expected, @district.statewide_testing.proficient_by_race_or_ethnicity(:asian)
  end

  def test_proficient_for_subject_by_grade_in_year_method_raises_an_error_with_any_invalid_parameter
    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_by_grade_in_year(:science, 8, 2011)
    end

    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 12, 2011)
    end
  end

  def test_proficient_for_subject_by_grade_in_year_method_returns_truncated_three_digit_percentage_float
    expected = 0.857

    assert_equal expected, @district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_proficient_for_subject_by_race_in_year_method_raises_an_error_with_any_invalid_parameter
    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_by_race_in_year(:history, :asian, 2010)
    end

    assert_raises UnknownDataError do
      @district.statewide_testing.proficient_for_subject_by_race_in_year(:writing, :japanese, 2010)
    end
  end

  def test_proficient_for_subject_by_race_in_year_method_returns_truncated_three_digit_percentage_float
    expected = 0.818

    assert_equal expected, @district.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
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
    expected = 0.689

    assert_equal expected, @district.statewide_testing.proficient_for_subject_in_year(:math, 2012)
  end

end
