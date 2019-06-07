require_relative("../models/booking")
require_relative("../models/gym_class")
require_relative("../models/member")
require("pry-byebug")

Member.delete_all()

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

binding.pry


nil
