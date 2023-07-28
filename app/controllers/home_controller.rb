# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.limit(16).order('created_at ASC')
  end
end
