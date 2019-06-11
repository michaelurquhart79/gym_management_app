require 'date'
require_relative('../db/sql_runner')
require_relative('./member')

class GymClass
  attr_reader( :id, :name, :class_time, :class_date, :capacity)
  attr_writer( :name, :class_time, :class_date, :capacity ) # only required for initial update method checking in pry

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @class_time = options['class_time']
    @class_date = options['class_date']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO gym_classes
    (name, class_time, class_date, capacity)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id"
    values = [@name, @class_time, @class_date, @capacity]
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
    SET (name, class_time, class_date, capacity)
    = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @class_time, @class_date, @capacity, @id]
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

  def time()
    return Time.parse("#{@class_date} #{@class_time}")
  end

  def date()
    return Date.parse(@class_date)
  end

  def future?()
    if self.time() > Time.now
      return true
    else
      return false
    end
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

  def self.destroy(id)
    sql = "DELETE FROM gym_classes WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM gym_classes WHERE id = $1"
    values = [id]
    class_hash = SqlRunner.run(sql, values)[0]
    class_object = GymClass.new(class_hash)
    return class_object
  end

  def self.future()
    gym_class_array = self.all()
    return gym_class_array.find_all{|gym_class| gym_class.future?}
  end

# GymClass.date_filtered(@filter_start, @filter_end)

  def self.date_filtered(start_date, end_date)
    gym_class_array = self.all()
    return gym_class_array.find_all do |gym_class|
      # (Date.parse(@class_date) >= Date.parse(start_date))
      after_start = (gym_class.date >= Date.parse(start_date))
      before_end = (gym_class.date <= Date.parse(end_date))

      after_start && before_end
    end
  end

end
