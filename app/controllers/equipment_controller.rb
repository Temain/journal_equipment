class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item,  only: [:edit, :update, :destroy, :repair, :relocation]
  before_action :load_departments, only: [:index, :new, :edit, :create, :update, :relocation]
  before_action :load_equipment_types, only: [:new, :edit, :create, :update]
  before_action :load_spares_array, only: [:index]

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
    reason = params[:reason].join if params[:reason]
    @repair = Repair.new(reason: reason)
    params[:spares].split(',').each do |spare|
      @repair.spares << Spare.find_or_create_by(id: spare, equipment_type_id: @item.equipment_type_id)
    end
    @repair.create_journal_record(equipment_id: @item.id, user_id: current_user.id, action_date: Time.now)
    if @repair.save
      flash[:notice] = "#{@item.full_name} успешно отправлен в ремонт."
    else
      flash[:danger] = "Извините, произошла ошибка."
    end
    redirect_to action: :index
  end

  def relocation
    new_department_id = params[:new_department_id].first
    if new_department_id.blank?
      flash[:danger] = "Пожалуйста, выберите подразделение."
    else
      new_department = Department.find(new_department_id) # Can throw RecordNotFound
      @relocation = Relocation.new(old_department_id: @item.department_id, new_department_id: new_department_id)
      @relocation.create_journal_record(equipment_id: @item.id, user_id: current_user.id, action_date: Time.now)
      @item.department = new_department
      if @relocation.save && @item.save
        flash[:notice] = "#{@item.full_name} успешно перемешен в подразделение #{new_department.name}."
      else
        flash[:danger] = "При перемещении произошла ошибка."
      end
    end
    redirect_to action: :index
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = "Указано несуществующее подразделение."
    redirect_to action: :index
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

  def load_spares
    if request.xhr?
      #@spares = EquipmentType.all.map { |type| [ type.name, type.spares.map { |spare| [spare.name, spare.id] }]}
      @spares = EquipmentType.find(params[:equipment_type_id]).spares.search(params[:q])
      respond_to do |format|
        format.json { render json: @spares }
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

    def load_spares_array
      @spares = EquipmentType.all.map { |type| [ type.name, type.spares.map { |spare| [spare.name, id: spare.id] }]}
    end

    def load_equipment_types
      @equipment_types = EquipmentType.all.map { |type| [type.name, type.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:model, :inventory_number, :equipment_type_id, :department_id)
    end
end