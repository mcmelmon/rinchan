class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  before_action :set_locale

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
