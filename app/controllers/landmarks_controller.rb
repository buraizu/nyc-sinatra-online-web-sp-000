class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  post '/landmarks/new' do
    @landmark = Landmark.create(name: params[:landmark][:name])
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
  end


end
