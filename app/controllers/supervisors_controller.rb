class SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!
  def index
  end
end
