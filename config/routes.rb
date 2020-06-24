# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  resource :garden do
    get :flowers
    get :birds
    get :path

    post :validate_step
  end
end
