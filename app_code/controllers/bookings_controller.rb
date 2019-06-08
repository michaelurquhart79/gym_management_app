require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/gym_class')
require_relative('../models/booking')
require_relative('../models/member')
also_reload('../modles/*')

get '/bookings' do
  @bookings = Booking.all
  erb(:"bookings/index")
end

get '/bookings/new' do
  erb(:"bookings/new")
end
