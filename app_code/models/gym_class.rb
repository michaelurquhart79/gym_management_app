require_relative('../db/sql_runner')

class GymClass
  attr_reader( :id, :name, :class_time, :class_date)
  attr_writer( :name, :class_time, :class_date )

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

end
