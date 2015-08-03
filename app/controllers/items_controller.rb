class ItemsController < ApplicationController
  #before_action :logged_in

  def index
    @location = Location.find(params[:location_id])
    @items = Item.order(name: :asc)
  end

  def show
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:id])
  end

  def new
    @location = Location.find(params[:location_id])
    @item = Item.new
    @status = Status.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      @status = Status.new(item_id: @item.id, name: "In", holder: nil, due: nil).save
      flash[:success] = "#{@item.name} added to the tracker!"
      redirect_to location_path(@item.location_id)
    else
      render "new"
    end
  end

  def edit
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:id])
    @status = Status.where(item_id: @item.id).last
  end

  def update
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "#{@item.name} updated!"
      redirect_to location_item_path(@location.id, @item.id)
    else
      render "edit"
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item Deleted"
    redirect_to location_path(params[:location_id])
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :image, :location_id)
    end

    def logged_in
      if current_user.nil?
        redirect_to root_path
        flash[:danger] = "Please log in before continuing."
      end
    end

end
