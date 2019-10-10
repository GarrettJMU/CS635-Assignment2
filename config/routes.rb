Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  post '/update', to: 'spreadsheet#update'
  post '/change_view', to: 'spreadsheet#change_view'
  post '/undo', to: 'spreadsheet#undo'

  root 'spreadsheet#index'

end
