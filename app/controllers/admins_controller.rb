class AdminsController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def listar_usuarios
    @users = User.all
  end
end
