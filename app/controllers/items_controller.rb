class ItemsController < ApplicationController
  #before_action :logged_in

  def index
    @items = Item.order(name: :asc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @status = Status.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      @status = Status.new(item_num: @item.id, name: "In", holder: nil, due: nil).save
      flash[:success] = "Item added to the tracker!"
      redirect_to index_path
    else
      render "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
    @status = Status.where(item_num: @item.id).last
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "#{@item.name} updated!"
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item Deleted"
    redirect_to index_path
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :image)
    end

    def logged_in
      if current_user.nil?
        redirect_to root_path
        flash[:danger] = "Please log in before continuing."
      end
    end

end
