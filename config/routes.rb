Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :items do
        collection { get 'search' }
      end
      resources :shops, only: [:index, :create] do
        collection { get 'names' }
      end
    end
  end
end
