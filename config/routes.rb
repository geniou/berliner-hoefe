BerlinerHoefe::Application.routes.draw do
  namespace :admin do
    resources :locations
    root to: 'locations#index'
  end

  get 'kontakt' => 'static#contact', as: :contact
  get 'impressum' => 'static#imprint', as: :imprint
  get 'datenschutz' => 'static#privacy', as: :privacy

  get '/hof/:id' => 'locations#redirect'
  get '/:id' => 'locations#show', as: :location

  root to: 'locations#index'
end
