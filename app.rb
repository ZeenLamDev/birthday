require 'sinatra/base'
require 'date'

class Birthday < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
  end

  post '/names' do
    session[:name] = params[:your_name]
    session[:bday_day] = params[:your_bday_day]
    session[:bday_month] = params[:your_bday_month]
    redirect "/countdown"
  end

  get '/countdown' do
    @name = session[:name]
    @bday_day = session[:bday_day]
    @bday_month = session[:bday_month]
    @day = @bday_day.to_i
    @month = @bday_month.to_i
    start_date = DateTime.now
    end_date = DateTime.new(2020, @month, @day)
    if start_date > end_date
      end_date = DateTime.new(2021, @month, @day)
    end
    @date = (start_date..end_date).count
    erb(:countdown)
  end

  run! if app_file == $0
end