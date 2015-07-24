class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item added to the tracker!"
      redirect_to @item
    else
      render "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated!"
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :image)
    end

end
