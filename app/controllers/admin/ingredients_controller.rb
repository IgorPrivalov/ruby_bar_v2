class Admin::IngredientsController < Admin::ApplicationController

  before_filter :find_item, only: [:edit, :update, :destroy, :show]

  def index

  end

  def new
    @ingredient = Ingredient.new
    coctaile = Coctaile.find_by(id: params[:coctaile_id])
    if coctaile.blank?
      flash[:warning] = "Can not found coctaile with id #{params[:coctaile_id]}"
      redirect_to request.referer.blank? ? root_url : request.referer
    else
      @ingredient.coctaile = coctaile
      session[:return_to] ||= request.referer
    end
  end

  def create
    @ingredient = Ingredient.create item_params
    redirect_to session.delete(:return_to)
  end

  def edit
    coctaile = Coctaile.find_by(id: params[:coctaile_id])
    if coctaile.blank?
      flash[:warning] = "Can not found coctaile with id #{params[:coctaile_id]}"
      redirect_to request.referer.blank? ? root_url : request.referer
    else
      @ingredient.coctaile = coctaile
      session[:return_to] ||= request.referer
    end
  end

  def show

  end

  def update

    @ingredient.update_attributes item_params
    if @ingredient.errors.empty?
      redirect_to session.delete(:return_to)
    else
      render 'edit'
    end
  end

  def destroy

  end

  def find_item
    @ingredient = Ingredient.where(id: params[:id]).first
  end

  def item_params
    params.require(:ingredient).permit(:id, :value, :coctaile_id, :product_id)
  end

end
