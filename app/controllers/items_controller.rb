class ItemsController < ApplicationController
  #ユーザー管理機能マージ後、devise提供の元 before_action :authenticate_user!, only: [:new]を追記予定
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:product, :category_id, :status_id, :delivery_fee_id, :region_id, :delivery_time_id, :value, :explanation, :user_id, :image)
  end

end
