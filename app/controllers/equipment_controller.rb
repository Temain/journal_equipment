class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item,  only: [:show, :edit, :update, :destroy]

  def index
    @equipment = Equipment.all
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Equipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      #params.require(:equipment).permit(:title, :content, :category_ids => [])
    end
end
