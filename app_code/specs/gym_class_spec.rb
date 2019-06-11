require 'minitest/autorun'
require_relative '../models/gym_class'

class TestGame < Minitest::Test


  def test_mon_07_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "07:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(false, result)
  end

  def test_mon_09_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "09:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(true, result)
  end

  def test_mon_10_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "10:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(true, result)
  end

  def test_mon_14_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "14:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(true, result)
  end

  def test_mon_17_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "17:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(false, result)
  end

  def test_mon_18_00
    class1 = GymClass.new({
      "name" => "Pilates",
      "class_time" => "18:00",
      "class_date" => "2019-06-17",
      "capacity" => "10"
      })
    result = class1.bookable_by_offpeak?()
    assert_equal(false, result)
  end


  # 
  # def test_sat_07_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "07:00",
  #     "class_date" => "2019-06-15",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sat_10_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "10:00",
  #     "class_date" => "2019-06-15",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sat_14_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "14:00",
  #     "class_date" => "2019-06-15",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sat_18_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "18:00",
  #     "class_date" => "2019-06-15",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sun_07_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "07:00",
  #     "class_date" => "2019-06-16",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sun_10_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "10:00",
  #     "class_date" => "2019-06-16",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sun_14_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "14:00",
  #     "class_date" => "2019-06-16",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end
  #
  # def test_sun_18_00
  #   class1 = GymClass.new({
  #     "name" => "Pilates",
  #     "class_time" => "18:00",
  #     "class_date" => "2019-06-16",
  #     "capacity" => "10"
  #     })
  #   result = class1.bookable_by_offpeak?()
  #   assert_equal(true, result)
  # end

end
