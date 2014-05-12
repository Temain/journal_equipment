class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item,  only: [:edit, :update, :destroy, :repair, :relocation]
  before_action :load_departments, only: [:index, :new, :edit, :create, :update]
  before_action :load_equipment_types, only: [:new, :edit, :create, :update]

  def index
    @equipment = Equipment.search(params[:search])
    @categories = Category.all
  end

  def show
  end

  def new
    @item = Equipment.new
    @item.manufacturer = Manufacturer.new
  end

  def edit
  end

  def create
    @item = Equipment.new(equipment_params)
    @manufacturer = Manufacturer.find_or_create_by(name: params[:manufacturer][:name])
    @item.manufacturer = @manufacturer
    if @item.save
      flash[:notice] = "Оборудование успешно добавлено."
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def update
    @manufacturer = Manufacturer.find_or_create_by(name: params[:manufacturer][:name])
    if !@manufacturer.name.empty? && @manufacturer.new_record?
      @manufacturer.save
      @item.manufacturer = @manufacturer
    end

    if @item.update(equipment_params)
      flash[:notice] = "Изменения успешно сохранены."
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
  end

  def repair

  end

  def relocation
    new_department = Department.find(params[:new_department_id]).first
    relocation = Relocation.new(old_department_id: @item.department_id, new_department_id: new_department.id)
    relocation.create_journal_record(equipment_id: @item.id, user_id: current_user.id, action_date: Time.now)
    @item.department = new_department
    if relocation.save && @item.save
      flash[:notice] = "#{@item.full_name} успешно перемешен в подразделение #{new_department.name}"
      #redirect_to controller: :history , action: :show, id: @item.id
      redirect_to equipment_index_path
      #render action: :relocation
    end
  end

  def load_manufacturers
    if request.xhr?
      @manufacturers = Manufacturer.search(params[:query])
      respond_to do |format|
        format.json { render json: @manufacturers }
      end
    end
  end

  def load_equipment
    if request.xhr?
      @equipment = Equipment.search_for_create(params[:query])
      respond_to do |format|
        format.json { render json: @equipment, include: [:manufacturer, :equipment_type] }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Equipment.find(params[:id])
    end

    def load_departments
      @departments = Department.all.map { |department| [department.name, department.id] }
    end

    def load_equipment_types
      @equipment_types = EquipmentType.all.map { |type| [type.name, type.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:model, :inventory_number, :equipment_type_id, :department_id)
    end
end
