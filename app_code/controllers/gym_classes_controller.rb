require('sinatra')
require('sinatra/contrib/all')
require("pry-byebug")
require_relative('../models/gym_class')
also_reload('../models/*')

get '/gym_classes' do
  @gym_classes = GymClass.all
  erb (:"gym_classes/index")
end

get '/gym_classes/new' do
  @date_today = Date.today
  erb (:"gym_classes/new")
end

get '/gym_classes/date_filtered' do
  @filter_start = params['filter_start_date']
  @filter_end = params['filter_end_date']
  @filtered_gym_classes = GymClass.date_filtered(@filter_start, @filter_end)
  erb ((:"gym_classes/date_filtered"))
end

get '/gym_classes/:id/members' do
  @gym_class = GymClass.find_by_id(params[:id])
  @gym_class_members = @gym_class.members
  # binding.pry
  erb (:"gym_classes/members")
end

get "/gym_classes/:id/edit" do
  @gym_class = GymClass.find_by_id(params[:id])
  erb (:"gym_classes/edit")
end

post '/gym_classes' do
  gym_class = GymClass.new(params)
  gym_class.save
  redirect to ('/gym_classes')
end

post '/gym_classes/:id/delete' do
  GymClass.destroy(params[:id])
  redirect to ('/gym_classes')
end

post '/gym_classes/:id/edit' do
  GymClass.new(params).update()
  redirect to ('/gym_classes')
end
