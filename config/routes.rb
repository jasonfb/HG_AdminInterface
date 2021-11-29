Rails.application.routes.draw do
  namespace :admin do
    resources :services # at the top level of the namespace

    resources :accounts do # at the top level of the namespace
      resources :invoices do
        resources :line_items do
          resources :sittings do
            # nothing here, you can leave this do block off if you want
          end
        end
      end
    end
  end

  devise_for :accounts
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
