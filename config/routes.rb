Rails.application.routes.draw do

  root 'directions#index'
  post '/directions' => 'directions#create_directions'
  get '/test/index' => 'test#index'


end
