Rails.application.routes.draw do

  root 'directions#index'
  post '/directions' => 'directions#create_directions'


end
