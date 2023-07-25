class HomeController < ApplicationController
  def index
    @users = User.limit(16)
  end
end
