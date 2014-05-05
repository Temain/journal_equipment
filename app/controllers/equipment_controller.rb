class EquipmentController < ApplicationController
  def index
    @equipment = Equipment.all
    @categories = Category.all
  end
end
