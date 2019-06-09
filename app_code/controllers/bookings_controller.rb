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
  @members = Member.all
  @gym_classes = GymClass.future
  erb(:"bookings/new")
end

post '/bookings/:id/delete' do
  booking = Booking.find_by_id(params[:id])
  booking.delete
  redirect to '/bookings'
end

post '/bookings' do
  gym_class = GymClass.find_by_id(params[:gym_class_id])
  member = Member.find_by_id(params[:id])
  member.book(gym_class)
  # binding.pry
  redirect to '/bookings'
end
