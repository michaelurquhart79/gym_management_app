require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member')
also_reload('../models/*')

get '/members' do
  erb (:"members/index")
end
