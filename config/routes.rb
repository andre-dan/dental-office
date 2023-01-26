Rails.application.routes.draw do
  post '/imc' => 'imc#imc'
  get '/get_token' => 'imc#get_token'
end
