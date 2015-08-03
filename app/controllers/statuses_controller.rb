class StatusesController < ApplicationController

  def checkin
    @item = Item.find(params[:item_id])
    @status = Status.new(item_id: @item.id, name: "In", holder: nil, due: nil)
    if @status.save
      flash[:success] = "#{@item.name} checked in!"
      redirect_to location_path(@item.location_id)
    else
    render location_path(@item.location_id)
    end
  end

  def checkout
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:item_id])
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @item = Item.find(params[:item_id])
    if @status.save
      flash[:success] = "#{@item.name} checked out!"
      redirect_to location_path(@item.location)
    else
      flash[:danger] = "Something went wrong. Please try again."
      redirect_to location_item_checkout_path
    end
  end

  private

  def status_params
    params.require(:status).permit(:item_id, :name, :holder, :due)
  end

end
