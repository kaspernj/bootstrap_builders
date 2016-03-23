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
        get :panel_with_table_and_custom_classes
      end
    end

    resources :tables, only: [] do
      collection do
        get :custom_classes
        get :normal_table
      end
    end

    resources :flashes, only: [] do
      collection do
        get :generate_flash
        get :show_flash
      end
    end

    resources :users
  end
end
