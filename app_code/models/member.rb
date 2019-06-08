require_relative('../db/sql_runner')
require_relative('./gym_class')
require_relative('./booking')


class Member
  attr_reader( :first_name, :last_name, :id)
  attr_writer( :first_name, :last_name) # for testing in pry only. Remove later.

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO members
    (first_name, last_name)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE members SET
    (first_name, last_name)
    =
    ($1, $2)
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def gym_classes()
    sql = "SELECT gym_classes.* FROM gym_classes
    INNER JOIN bookings ON gym_classes.id = bookings.gym_class_id
    WHERE bookings.member_id = $1"
    values = [@id]
    gym_class_hashes = SqlRunner.run(sql, values)
    gym_class_objects = gym_class_hashes.map{|gym_class| GymClass.new(gym_class)}
    return gym_class_objects
  end

  def book(gym_class)
    booking = Booking.new({
      "member_id" => @id,
      "gym_class_id" => gym_class.id
      })
    booking.save()
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM members"
    members_hashes = SqlRunner.run(sql)
    members_objects = members_hashes.map {|member| Member.new(member)}
    return members_objects
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    member_hash = SqlRunner.run(sql, values)[0]
    member_object = Member.new(member_hash)
    return member_object
  end


end
