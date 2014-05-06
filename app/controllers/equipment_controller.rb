class EquipmentController < ApplicationController
  before_action :authenticate_user!

  def index
    @equipment = Equipment.all
    @categories = Category.all
  end
end
