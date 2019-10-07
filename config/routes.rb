Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get '/equation', to: 'spreadsheet#equation'
  root 'spreadsheet#value'
end
