class SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!
  def index
  end

  def listar_users
    @users = User.all
  end

end
