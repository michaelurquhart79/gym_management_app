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

end
