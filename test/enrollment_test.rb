require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require './lib/district_repository'

class EnrollmentTest < Minitest::Test

  # def setup
  #   skip
  # end

  def test_dropout_rate_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_dropout_rate_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.dropout_rate_in_year(0000)

    assert_equal expected, @enrollment.dropout_rate_in_year(" ")

    assert_equal expected, @enrollment.dropout_rate_in_year(1980)
  end

  def test_dropout_rate_in_year_method
    path = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")
    # enrollment = Enrollment.new(district_data)

    assert_equal 0.004, district.enrollment.dropout_rate_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_dropout_rate_by_gender_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.dropout_rate_by_gender_in_year(0000)

    assert_equal expected, @enrollment.dropout_rate_by_gender_in_year(" ")

    assert_equal expected, @enrollment.dropout_rate_by_gender_in_year(1980)
  end

  def test_dropout_rate_by_gender_in_year_method_returns_hash_with_genders_as_keys_and_three_digit_percentage_floats
    skip
    expected = {:female => 0.002, :male => 0.002}

    assert_equal expected, @enrollment.dropout_rate_by_gender_in_year(2012)
  end

  def test_dropout_rate_by_race_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_dropout_rate_by_race_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.dropout_rate_by_race_in_year(0000)

    assert_equal expected, @enrollment.dropout_rate_by_race_in_year(" ")

    assert_equal expected, @enrollment.dropout_rate_by_race_in_year(1980)
  end

  def test_dropout_rate_by_race_in_year_method_returns_hash_with_race_as_keys_and_three_digit_percentage_floats
    skip
    expected = { :asian => 0.001,
                 :black => 0.001,
                 :pacific_islander => 0.001,
                 :hispanic => 0.001,
                 :native_american => 0.001,
                 :two_or_more => 0.001,
                 :white => 0.001
               }

    assert_equal expected, @enrollment.dropout_rate_by_race_in_year(2012)
  end

  def test_dropout_rate_for_race_or_ethnicity_method_takes_valid_parameter
    skip
    #should take in race as a symbol from: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  end

  def test_dropout_rate_for_race_or_ethnicity_method_raises_an_error_with_unknown_race
    skip
    assert_raises UnknownRaceError do
      @enrollment.dropout_rate_for_race_or_ethnicity(:german)
    end
  end

  def test_dropout_rate_for_race_or_ethnicity_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_float
    skip
    expected = [2011 => 0.047, 2012 => 0.041]

    assert_equal expected, @enrollment.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_takes_valid_two_parameters
    skip
    #should return race as a symbol from: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    #year as an integer
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1940)

    assert_equal expected, @enrollment.dropout_rate_for_race_or_ethnicity_in_year(:white, 666)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_three_digit_percentage_float
    skip
    expected = 0.001

    assert_equal expected, @enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
  end

  def test_graduation_rate_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_float
    skip
    expected = { 2010 => 0.895,
                 2011 => 0.895,
                 2012 => 0.889,
                 2013 => 0.913,
                 2014 => 0.898,
               }

    assert_equal expected, @enrollment.graduation_rate_by_year
  end

  def test_graduation_rate_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_graduation_rate_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.graduation_rate_in_year(1937)
  end

  def test_graduation_rate_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.895

    assert_equal expected, @enrollment.graduation_rate_in_year(2010)
  end

  def test_kindergarten_participation_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    skip
    expected = { 2010 => 0.391,
                 2011 => 0.353,
                 2012 => 0.267,
                 2013 => 0.487,
                 2014 => 0.490,
               }

    assert_equal expected, @enrollment.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_kindergarten_participation_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.kindergarten_participation_in_year(1999)
  end

  def test_kindergarten_participation_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.391

    assert_equal expected, @enrollment.kindergarten_participation_in_year(2010)
  end

  def test_online_participation_by_year_method_returns_a_hash_with_years_as_keys_and_an_integer_as_value
    skip
    expected = { 2010 => 16,
                 2011 => 18,
                 2012 => 24,
                 2013 => 32,
                 2014 => 40,
               }

    assert_equal expected, @enrollment.online_participation_by_year
  end

  def test_online_participation_in_year_method_takes_valid_parameter
    skip
    #should take in year as an integer
  end

  def test_online_participation_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal nil, @enrollment.online_participation_in_year(1990)
  end

  def test_online_participation_in_year_method_returns_a_single_integer
    skip
    expected = 33

    assert_equal expected, @enrollment.online_participation_in_year(2013)
  end

  def test_participation_by_year_method_returns_a_hash_with_years_as_keys_and_an_integer_as_value
    skip
    expected = { 2009 => 22620,
                 2010 => 22620,
                 2011 => 23119,
                 2012 => 23657,
                 2013 => 23973,
                 2014 => 24578,
               }

    assert_equal expected, @enrollment.participation_by_year
  end

  def test_participation_in_year_method_takes_valid_parameter
    skip
    #takes in year as an integer
  end

  def test_participation_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.participation_in_year(1650)
  end

  def test_participation_in_year_method_returns_returns_a_single_integer
    skip
    expected = 23973

    assert_equal expected, @enrollment.participation_in_year(2013)
  end

  def test_participation_by_race_or_ethnicity_method_takes_valid_parameter
    skip
    #should take in race as a symbol from: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  end

  def test_participation_by_race_or_ethnicity_raises_an_error_with_any_unknown_race
    skip
    assert_raises UnknownRaceError do
      @enrollment.participation_by_race_or_ethinicity(:nepalese)
    end
  end

  def test_participation_by_race_or_ethnicity_returns_a_hash_with_years_as_keys_and_three_digit_percentage_float
    skip
    expected = { 2011 => 0.047,
                 2012 => 0.041,
                 2013 => 0.052,
                 2014 => 0.056
               }

    assert_equal expected, @enrollment.participation_by_race_or_ethinicity(:asian)
  end

  def test_participation_by_race_or_ethnicity_in_year_method_takes_valid_paramter
    skip
    #takes in year as an integer
  end

  def test_participation_by_race_or_ethnicity_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal expected, @enrollment.participation_by_race_or_ethinicity_in_year(1900)
  end

  def test_participation_by_race_or_ethnicity_in_year_method_returns_a_hash_with_race_as_keys_and_three_digit_percentage_float
    skip
    expected =  { :asian => 0.036,
                  :black => 0.029,
                  :pacific_islander => 0.118,
                  :hispanic => 0.003,
                  :native_american => 0.004,
                  :two_or_more => 0.050,
                  :white => 0.756
                 }

    assert_equal expected, @enrollment.participation_by_race_or_ethinicity_in_year(2012)
  end

  def test_special_education_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_floats
    skip
    expected = { 2009 => 0.075,
                 2010 => 0.078,
                 2011 => 0.072,
                 2012 => 0.071,
                 2013 => 0.070,
                 2014 => 0.068,
               }

    assert_equal expected, @enrollment.special_education_by_year
  end

  def test_special_education_in_year_method_takes_valid_parameter
    skip
    #should take in year as integer
  end

  def test_special_education_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal nil, @enrollment.special_education_in_year(2020)
  end

  def test_special_education_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.105

    assert_equal expected, @enrollment.special_education_in_year(2013)
  end

  def test_remediation_by_year_method_returns_a_hash_with_years_as_keys_and_three_digit_percentage_float
    skip
    expected = { 2009 => 0.232,
                 2010 => 0.251,
                 2011 => 0.278
               }

    assert_equal expected, @enrollment.remediation_by_year
  end

  def test_remediation_in_year_method_takes_valid_parameter
    skip
    #takes in year as an integer
  end

  def test_remediation_in_year_method_returns_nil_with_any_unknown_year
    skip
    expected = nil

    assert_equal nil, @enrollment.remediation_in_year(2222)
  end

  def test_remediation_in_year_method_returns_three_digit_percentage_float
    skip
    expected = 0.250

    assert_equal expected, @enrollment.remediation_in_year(2010)
  end

end
