Rails.application.routes.draw do
  
  resources :call_tracking, except: [:new, :index, :edit, :destroy, :update, :create, :show] do
    collection do
      get :call_to_user
      post :user_screen_call
      
      # User Select input
      post :user_screen_call_response
      get :user_selection_callback
      post :status_callback
    end
  end

  resources :sms_tracking, except: [:new, :index, :edit, :destroy, :update, :create, :show] do
    collection do
      #when receive sms from User
      post :sms_request
      post :status_callback
    end
  end

end
