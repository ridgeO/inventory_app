class StatusesController < ApplicationController

  def checkin
    @item = Item.find(params[:id])
    @status = Status.new(item_num: @item.id, name: "In", holder: nil, due: nil)
    @status.save
    redirect_to index_path
  end

  def checkout
    @item = Item.find(params[:id])
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @item = Item.find(status_params[:item_num]).name
    if @status.save
      flash[:success] = "#{@item} checked out!"
      redirect_to index_path
    else
      render "statuses/checkout"
    end
  end

  private

  def status_params
    params.require(:status).permit(:item_num, :name, :holder, :due)
  end

end
