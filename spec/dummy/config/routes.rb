Rails.application.routes.draw do
  mount BootstrapBuilders::Engine => "/bootstrap_builders"

  namespace :bootstrap_builders do
    resources :attribute_rows, only: []

    resources :buttons, only: [] do
      collection do
        get :edit_btn
      end
    end

    resources :panels, only: [] do
      collection do
        get :panel_with_content
        get :panel_with_table
      end
    end

    resources :tables, only: []
  end
end
