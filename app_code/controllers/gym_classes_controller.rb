require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class')
also_reload('../models/*')

get '/gym_classes' do
  erb (:"gym_classes/index")
end
