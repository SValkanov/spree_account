class Spree::UsersController < Spree::StoreController
  skip_before_action :set_current_order, only: :show
  prepend_before_action :load_object, only: [:show, :edit, :update]
  prepend_before_action :authorize_actions, only: [:new]
  before_filter :require_auth, only: [:orders, :addresses]

  include Spree::Core::ControllerHelpers

  def show
    @bill_address = spree_current_user.bill_address
    @ship_address = spree_current_user.ship_address
  end

  def create
    @user = Spree::User.new(user_params)
    if @user.save

      if current_order
        session[:guest_token] = nil
      end

      redirect_back_or_default(root_url)
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      if params[:user][:password].present?
        # this logic needed b/c devise wants to log us out after password changes
        user = Spree::User.reset_password_by_token(params[:user])
        sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
      end
      if params[:user][:username].present?
        # this logic needed b/c devise wants to log us out after password changes
        spree_current_user.update_attributes(username: params[:user][:username])
        #sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
      end
      redirect_to spree.account_url, :notice => Spree.t(:account_updated)
    else
      render :edit
    end
  end

  def orders
    @orders = spree_current_user.orders.complete.order('completed_at desc')
  end

  def addresses
    @ship_address = spree_current_user.ship_address || Spree::Address.new(country_id: Spree::Config[:default_country_id])
    @bill_address = spree_current_user.bill_address || Spree::Address.new(country_id: Spree::Config[:default_country_id])

    if params[:address_type].present?
      @address = Spree::Address.new(address_params)
      case params[:address_type]
      when 'shipping'
        if spree_current_user.update_attributes(shipping_address: @address)
          @ship_address = @address
          redirect_to '/account/addresses', notice: Spree.t(:address_updated)
        end
      when 'billing'
        if spree_current_user.update_attributes(billing_address: @address)
          @bill_address = @address
          redirect_to '/account/addresses', notice: Spree.t(:address_updated)
        end
      end
    end
  end

  private

  def require_auth
    unless spree_current_user
      redirect_to '/login'
    end
  end

  def user_params
    params.require(:user).permit(Spree::PermittedAttributes.user_attributes)
  end

  def address_params
    params.require(:address).permit(Spree::PermittedAttributes.address_attributes)
  end

  def load_object
    @user ||= spree_current_user
    authorize! params[:action].to_sym, @user
  end

  def authorize_actions
    authorize! params[:action].to_sym, Spree::User.new
  end
end
