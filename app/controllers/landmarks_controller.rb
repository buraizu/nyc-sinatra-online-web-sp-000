class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end


end
