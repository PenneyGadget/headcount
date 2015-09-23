require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile'
require './lib/district_repository'


class EconomicProfileTest < Minitest::Test

  #high level test from Josh
  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20") #object of district class

    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end

  def test_free_or_reduced_lunch_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    skip
    expected = { 2000 => 0.020,
                 2001 => 0.024,
                 2002 => 0.027,
                 2003 => 0.030,
                 2004 => 0.034,
                 2005 => 0.058,
                 2006 => 0.041,
                 2007 => 0.050,
                 2008 => 0.061,
                 2009 => 0.070,
                 2010 => 0.079,
                 2011 => 0.084,
                 2012 => 0.125,
                 2013 => 0.091,
                 2014 => 0.087,
               }

    assert_equal expected, @economic_profile.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year_method_takes_valid_parameter
    skip
    #takes in year as integer
  end

  def test_free_or_reduced_lunch_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @economic_profile.free_or_reduced_lunch_in_year(2030)
  end

  def test_free_or_reduced_lunch_in_year_method_returns_three_digit_percentage_float
    skip
    #typo in spec
  end

  def test_school_aged_children_in_poverty_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    skip
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
                 2010 => 0.057,
                 2011 => 0.059,
                 2012 => 0.064,
                 2013 => 0.048,
               }

    assert_equal expected, @economic_profile.school_aged_children_in_poverty_in_year
  end

  def test_school_aged_children_in_poverty_by_year_method_returns_an_empty_hash_if_district_data_is_not_present
    skip
    # expected = []
    #
    # assert_equal expected, something
  end

  def test_school_aged_children_in_poverty_in_year_method_takes_valid_parameter
    skip
    #takes year as integer
  end

  def test_school_aged_children_in_poverty_in_year_method_returns_nil_for_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @economic_profile.school_aged_children_in_poverty_in_year(1111)
  end

  def test_school_aged_children_in_poverty_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.064

    assert_equal expected, @economic_profile.school_aged_children_in_poverty_in_year(2012)
  end

  def test_title_1_students_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    skip
    expected = {2009 => 0.014, 2011 => 0.011, 2012 => 0.01, 2013 => 0.012, 2014 => 0.027}

    assert_equal expected, @economic_profile.title_1_students_by_year
  end

  def test_title_1_students_by_year_method_returns_an_empty_hash_if_the_district_data_is_not_present
    skip
    expected = []

    assert_equal expected, something
  end

  def test_title_1_students_in_year_method_takes_valid_parameter
    skip
    #takes year as an integer
  end

  def test_title_1_students_in_year_method_returns_nil_for_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @economic_profile.title_1_students_in_year(3333)
  end

  def test_title_1_students_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.01

    assert_equal expected, @economic_profile.title_1_students_in_year(2012)
  end

end
