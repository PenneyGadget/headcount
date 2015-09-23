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


end
