class MaterialsController < ApplicationController
  before_action :set_material, only: [:edit, :update, :destroy]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)

    if @material.save
      redirect_to materials_url, notice: 'Material was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @material.update(material_params)
      redirect_to materials_url, notice: 'Material was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @material.destroy
      redirect_to materials_url, notice: 'Material was successfully destroyed.'
    else
      redirect_to materials_url, notice: 'Material was not destroyed.'
    end
  end

  private

  def set_material
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:supplier_id, :name, :url, :cost)
  end
end
