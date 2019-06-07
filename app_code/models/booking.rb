require_relative('../db/sql_runner')

class Booking

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

  def self.delete_all
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    bookings_hashes = SqlRunner.run(sql)
    bookings_objects = bookings_hashes.map {|booking| Booking.new(booking)}
    return bookings_objects
  end



end
