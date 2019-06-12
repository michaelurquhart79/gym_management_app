require_relative('../db/sql_runner')

class Booking
  attr_reader :id, :member_id, :gym_class_id
  attr_writer :member_id, :gym_class_id # should only be need to test update method using pry in seeds file

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @gym_class_id = options['gym_class_id'].to_i
  end

  def save()
    sql = "INSERT INTO bookings
    (member_id, gym_class_id) VALUES ($1, $2)
    RETURNING id"
    values = [@member_id, @gym_class_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE bookings SET
    (member_id, gym_class_id) =
    ($1, $2)
    WHERE id = $3"
    values = [@member_id, @gym_class_id, @id]
    SqlRunner.run(sql, values)
  end

  def member()
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [@member_id]
    member_hash = SqlRunner.run(sql, values)[0]
    member_object = Member.new(member_hash)
  end

  def gym_class()
    sql = "SELECT * FROM gym_classes
    WHERE id = $1"
    values = [@gym_class_id]
    gym_class_hash = SqlRunner.run(sql, values)[0]
    gym_class_object = GymClass.new(gym_class_hash)
    return gym_class_object
  end


  def self.delete_all
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM bookings ORDER BY member_id ASC"
    bookings_hashes = SqlRunner.run(sql)
    bookings_objects = bookings_hashes.map {|booking| Booking.new(booking)}
    return bookings_objects
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM bookings WHERE id = $1"
    values = [id]
    booking_hash = SqlRunner.run(sql, values)[0]
    booking_object = Booking.new(booking_hash)
    return booking_object
  end

  def self.find_by_member_class_ids(member_id, gym_class_id)
    sql = "SELECT * FROM bookings WHERE member_id = $1 AND gym_class_id = $2"
    values = [member_id, gym_class_id]
    booking_hash = SqlRunner.run(sql, values)[0]
    booking_object = Booking.new(booking_hash)
    return booking_object
  end


end
