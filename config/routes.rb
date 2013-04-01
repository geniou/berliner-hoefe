BerlinerHoefe::Application.routes.draw do

  get '/hof/:id' => 'locations#redirect'
  get '/:id' => 'locations#show', as: 'location'

  root :to => 'locations#index'

  namespace :admin do
    resources :locations do
      collection do
        post 'massoperation'
      end
    end
  end
end
