class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :"application/index"
  end


  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    if params[:landmark][:name]
      landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << landmark
    end
    if params[:title][:name]
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
    end
    @figure.save
    redirect '/figures/#{figure.id}'
  end

  post '/figures/new' do

    figure = Figure.create(name: params[:figure][:name])
    if params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id|
        title = Title.find_by_id(id)
        figure.titles << title
      end
    end
    if params[:title][:name]
      title = Title.create(name: params[:title][:name])
      figure.titles << title
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        landmark = Landmark.find_by_id(id)
        figure.landmarks << landmark
      end
    end
    if params[:landmark][:name]
      landmark = Landmark.create(name: params[:landmark][:name])
      figure.landmarks << landmark
    end
    figure.save
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
end
