require_relative("../models/booking")
require_relative("../models/gym_class")
require_relative("../models/member")
require("pry-byebug")

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

member1 = Member.new({
  "first_name" => "Michael",
  "last_name" => "Urquhart"
  })
member1.save

member2 = Member.new({
  "first_name" => "Steven",
  "last_name" => "Morrison"
  })
member2.save

class1 = GymClass.new({
  "name" => "Pilates",
  "class_time" => "09:00",
  "class_date" => "2019-06-11"
  })
class1.save

class2 = GymClass.new({
  "name" => "Yoga",
  "class_time" => "10:00",
  "class_date" => "2019-06-15"
  })
class2.save

booking1 = Booking.new({
  "member_id" => member1.id,
  "gym_class_id" => class1.id
  })
booking1.save

booking2 = Booking.new({
  "member_id" => member1.id,
  "gym_class_id" => class2.id
  })
booking2.save

booking3 = Booking.new({
  "member_id" => member2.id,
  "gym_class_id" => class2.id
  })
booking3.save

binding.pry

nil
