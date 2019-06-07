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

end
