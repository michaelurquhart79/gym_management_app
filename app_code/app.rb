require('sinatra')
require('sinatra/contrib/all')
also_reload("./models/*")
require_relative('./controllers/bookings_controller')
require_relative('./controllers/gym_classes_controller')
require_relative('./controllers/members_controller')

get '/' do
  erb( :index )
end
