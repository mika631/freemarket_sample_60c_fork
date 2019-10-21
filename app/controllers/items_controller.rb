class ItemsController < ApplicationController
  before_action :header_category 

  require 'payjp'

  def index
    @parents = Category.all.where(ancestry: nil)
    @user = current_user
    @items = Item.all.order("created_at DESC") 
    @category = Category.all.where(id: [1,2,8,6])
    @brand = Brand.all.where(id: [168,197,1625,6541])
  end 

  def show
    @item = Item.find(params[:id])
    @items = Item.order("created_at DESC") 
  end

  def new
    @parents = Category.all.where(ancestry: nil)
    @item = Item.new
    @item.images.build
    @item.build_shipping
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      @item.images = []
      @item.images.build
      @parents = Category.all.where(ancestry: nil)
      render :new
    end
  end

  def search
    @items = Item.where('name LIKE(?)',"%#{params[:keyword]}%").limit(20)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def confirmation
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
      if card.blank?
        redirect_to controller: "card", action: "new"
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.cards.retrieve(card.card_id)
      end
  end

  def buy
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      amount:  @item.price,
      customer: card.customer_id,
      currency: 'jpy'
    )

    @trader = Trader.new(
      seller_id: @item.user.id,
      buyer_id: current_user.id
    )
    @trader.save

    @trading = Trading.new(
      condition: @item.condition.id,
      delivery_to: 1,
      payment: 1,
      status: 1,
      item_id: @item.id,
      trader_id: @trader.id,
      shipping_id: 1
    )
    @trading.save

    redirect_to action: "done"
  end

  def done
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :text,
      :category_id,
      :brand_id,
      :size_id,
      :condition_id,
      :display_id,
      shipping_attributes: [:id,:delivery_method_id,:prefecture_id, :charge, :term_id],
      images_attributes: [:url]
      )
      .merge(user_id: current_user.id)
  end
end
