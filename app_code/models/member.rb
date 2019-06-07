require_relative('../db/sql_runner')


class Member
  attr_reader( :first_name, :last_name)

  def initialize(options)
    @first_name = options['first_name']
    @second_name = options['last_name']
    @id = options['id'] if options['id']
  end



end
