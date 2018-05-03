class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  before_action :set_locale

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
