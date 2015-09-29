require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile'
require './lib/district_repository'


class EconomicProfileTest < Minitest::Test

  def setup
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    @district   = repository.find_by_name("ACADEMY 20")
  end

  def test_free_or_reduced_lunch_in_year
    assert_equal 0.125, @district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end

  def test_free_or_reduced_lunch_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    expected = { 2000 => 0.04,
                 2001 => 0.047,
                 2002 => 0.048,
                 2003 => 0.06,
                 2004 => 0.059,
                 2005 => 0.058,
                 2006 => 0.072,
                 2007 => 0.08,
                 2008 => 0.093,
                 2009 => 0.103,
                 2010 => 0.113,
                 2011 => 0.119,
                 2012 => 0.125,
                 2013 => 0.131,
                 2014 => 0.127,
               }

    assert_equal expected, @district.economic_profile.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year_method_returns_nil_with_any_unknown_year
    expected = nil

    assert_equal expected, @district.economic_profile.free_or_reduced_lunch_in_year(2030)
  end

  def test_school_aged_children_in_poverty_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    expected = { 1995 => 0.032,
                 1997 => 0.035,
                 1999 => 0.032,
                 2000 => 0.031,
                 2001 => 0.029,
                 2002 => 0.033,
                 2003 => 0.037,
                 2004 => 0.034,
                 2005 => 0.042,
                 2006 => 0.036,
                 2007 => 0.039,
                 2008 => 0.044,
                 2009 => 0.047,
                 2010 => 0.058,
                 2011 => 0.059,
                 2012 => 0.064,
                 2013 => 0.048,
               }

    assert_equal expected, @district.economic_profile.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_by_year_method_returns_an_empty_hash_if_district_data_is_not_present
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("not a district")

    expected = {}

    assert_equal expected, district.economic_profile.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year_method_returns_nil_for_any_unknown_year
    expected = nil

    assert_equal expected, @district.economic_profile.school_aged_children_in_poverty_in_year(1111)
  end

  def test_school_aged_children_in_poverty_in_year_method_returns_three_digit_percentage_float
    expected = 0.064

    assert_equal expected, @district.economic_profile.school_aged_children_in_poverty_in_year(2012)
  end

  def test_title_1_students_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    expected = {2009 => 0.014, 2011 => 0.011, 2012 => 0.011, 2013 => 0.012, 2014 => 0.027}

    assert_equal expected, @district.economic_profile.title_1_students_by_year
  end

  def test_title_1_students_by_year_method_returns_an_empty_hash_if_the_district_data_is_not_present
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("not a district")

    expected = {}

    assert_equal expected, district.economic_profile.title_1_students_by_year
  end

  def test_title_1_students_in_year_method_returns_nil_for_any_unknown_year
    expected = nil

    assert_equal expected, @district.economic_profile.title_1_students_in_year(3333)
  end

  def test_title_1_students_in_year_method_returns_three_digit_percentage_float
    expected = 0.011

    assert_equal expected, @district.economic_profile.title_1_students_in_year(2012)
  end

end
