Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'channels#index'
    devise_for :users

    resource :system_setting, except: :destroy
    resources :channels do
      member do
        put :build_statistics
        put :update_snippet
      end
      collection do
        put :build_all_statistics
        put :update_all_snippets
      end
    end
  end
end
