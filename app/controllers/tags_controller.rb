class TagsController < ApplicationController
  require 'will_paginate/array'

  def show
    @tag = Tag.find_by(id: params[:id])
    @topics = Topic.with_tag(@tag&.name).paginate(page: params[:page])
  end
end
