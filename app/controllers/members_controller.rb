# frozen_string_literal: true

class MembersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end