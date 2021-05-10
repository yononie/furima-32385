class PurchaseLogsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index]
  before_action :solditem_matcher, only: [:index]
  before_action :item_user_matcher, only: [:index]
  def index
    @destination_purchase_log = DestinationPurchaseLog.new
  end

  def create
    @destination_purchase_log = DestinationPurchaseLog.new(order_params)
    if @destination_purchase_log.valid?
      pay_item
      @destination_purchase_log.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:destination_purchase_log).permit(:region_id, :city, :address, :building_name, :postal_code, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).value,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_user_matcher
    redirect_to root_path if current_user.id == @item.user_id
  end

  def solditem_matcher
    redirect_to root_path unless @item.purchase_log.nil?
  end
end
