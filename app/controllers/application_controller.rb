class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :"application/index"
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
    redirect 'figures/#{@figure.id}'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

end
