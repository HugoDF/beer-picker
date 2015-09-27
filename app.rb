require 'rubygems'
require 'sinatra'
require 'yaml'

enable :sessions

beers = YAML.load_file('./beers.yaml');

get '/' do
  @locations = beers.keys
  if(@locations.include?params[:location])
    @beers = beers[params[:location]]
    @selected_location = params[:location]
  else
    @beers = beers[@locations.first]
    @selected_location = @locations.first
  end
  @beer = @beers.sample
  while(@beer["title"]==session[:prev]) do
    @beer = @beers.sample
    # puts "re-done"
  end
  session[:prev] = @beer['title']
  erb :index
end

get '/view_all' do
  @locations = beers.keys
  if(@locations.include?params[:location])
    @beers = beers[params[:location]]
    @selected_location = params[:location]
  else
    @beers = beers[@locations.first]
    @selected_location = @locations.first
  end
  erb :view_all
end
set :public_folder, File.dirname(__FILE__) + '/public'