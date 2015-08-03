class StatusesController < ApplicationController

  def checkin
    @item = Item.find(params[:id])
    @status = Status.new(item_id: @item.id, name: "In", holder: nil, due: nil)
    if @status.save
      flash[:success] = "#{@item.name} checked in!"
      redirect_to index_path
    else
    render index_path
    end
  end

  def checkout
    @item = Item.find(params[:id])
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @item = Item.find(status_params[:item_id])
    if @status.save
      flash[:success] = "#{@item.name} checked out!"
      redirect_to index_path
    else
      render "statuses/checkout"
    end
  end

  private

  def status_params
    params.require(:status).permit(:item_id, :name, :holder, :due)
  end

end
