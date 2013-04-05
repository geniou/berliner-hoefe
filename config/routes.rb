BerlinerHoefe::Application.routes.draw do
  namespace :admin do
    resources :locations do
      collection do
        post 'massoperation'
      end
    end
    root to: 'locations#index'
  end

  get '/hof/:id' => 'locations#redirect'
  get '/:id' => 'locations#show', as: 'location'

  root to: 'locations#index'
end
