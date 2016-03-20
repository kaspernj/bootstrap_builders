Rails.application.routes.draw do
  devise_for :users
  mount BootstrapBuilders::Engine => "/bootstrap_builders"

  namespace :bootstrap_builders do
    resources :attribute_rows, only: [] do
      collection do
        get :model_rows
      end
    end

    resources :buttons, only: [] do
      collection do
        get :destroy_btn
        get :edit_btn
        get :new_btn
        get :show_btn
      end
    end

    resources :panels, only: [] do
      collection do
        get :panel_with_content
        get :panel_with_table
      end
    end

    resources :tables, only: []
    resources :users
  end
end
