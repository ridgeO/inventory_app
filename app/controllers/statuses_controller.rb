class StatusesController < ApplicationController
  before_action :logged_in

  def checkin
    @item = Item.find(params[:item_id])
    @status = Status.new(item_id: @item.id, name: "In", start_time: Date.today, holder: nil, due: nil)
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

  def req
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:item_id])
    @start_time = params[:start_time]
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @location = Location.find(params[:location_id])
    @item = Item.find(params[:item_id])
    if @status.save
      if @status.name == "Out"
        flash[:success] = "#{@item.name} checked out!"
      elsif @status.name == "Req"
        flash[:success] = "#{@item.name} requested!"
      end
      redirect_to location_path(@location)
    else
      if @status.name == "Out"
        render "statuses/checkout"
      elsif @status.name == "Req"
        render "statuses/req"
      end
    end
  end

  private

  def status_params
    params.require(:status).permit(:item_id, :name, :holder, :due, :start_time)
  end

end
