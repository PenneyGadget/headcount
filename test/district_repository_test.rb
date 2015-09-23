require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'


class DistrictRepositoryTest < Minitest::Test

  #to line 24 is from Shannon
  #  def setup
  #    @dr ||= DistrictRepository.from_csv(data_dir) #||= tells programs "if this IVAR has already been assigned, then don't reassign it" - suposed to make files load faster - not sure which file take precidence
  #    @district = @dr.find_by_name("ACADEMY 20")
  #  end
   #
  #  def data_dir
  #    File.expand_path '../data', __dir__
  #  end
  #  meta(current: true)
   #
  #  def test_it_can_load_a_district_from_csv_data
  #    assert_equal "ACADEMY 20", @district.district_name
  #    assert_equal 22620, @district.enrollment.in_year(2009)
  #    # assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
  #    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  #  end

   def test_find_by_name_method_returns_either_nil_or_an_instance_of_district_with_a_case_insensitive_search
     skip
   end

   def test_find_all_matching_method_returns_either_empty_array_or_matches
     skip
   end

 end
