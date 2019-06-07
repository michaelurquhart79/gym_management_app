require_relative('../db/sql_runner')
require_relative('./member')

class GymClass
  attr_reader( :id, :name, :class_time, :class_date)
  attr_writer( :name, :class_time, :class_date ) # only required for initial update method checking in pry

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @class_time = options['class_time']
    @class_date = options['class_date']
  end

  def save()
    sql = "INSERT INTO gym_classes
    (name, class_time, class_date)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@name, @class_time, @class_date]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def delete()
    sql = "DELETE FROM gym_classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE gym_classes
    SET (name, class_time, class_date)
    = ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @class_time, @class_date, @id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT members.* FROM members
    INNER JOIN bookings ON members.id = bookings.member_id
    WHERE bookings.gym_class_id = $1"
    values = [@id]
    members_hashes = SqlRunner.run(sql, values)
    members_objects = members_hashes.map {|member| Member.new(member)}
  end

  def self.all()
    sql = "SELECT * FROM gym_classes"
    classes_hashes = SqlRunner.run(sql)
    classes_objects = classes_hashes.map{|gym_class| GymClass.new(gym_class)}
    return classes_objects
  end

  def self.delete_all()
    sql = "DELETE FROM gym_classes"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM gym_classes WHERE id = $1"
    values = [id]
    class_hash = SqlRunner.run(sql, values)[0]
    class_object = GymClass.new(class_hash)
    return class_object
  end

end
