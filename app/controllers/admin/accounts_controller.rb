class Admin::AccountsController < Admin::BaseController
  helper :hot_glue
  include HotGlue::ControllerHelper

  
  
  before_action :load_account, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }



  


  def load_account
    @account = Account.find(params[:id])
  end
  

  def load_all_accounts
    @accounts = Account.page(params[:page])
    
  end

  def index
    load_all_accounts
    respond_to do |format|
       format.html
    end
  end

  def new 
    @account = Account.new
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(account_params.dup )
    @account = Account.create(modified_params)

    if @account.save
      flash[:notice] = "Successfully created #{@account.name}"
      load_all_accounts
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_accounts_path }
      end
    else
      flash[:alert] = "Oops, your account could not be created."
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @account.update(modify_date_inputs_on_params(account_params))
      flash[:notice] = "Saved #{@account.name}"
    else
      flash[:alert] = "Account could not be saved."
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @account.destroy
    rescue StandardError => e
      flash[:alert] = "Account could not be deleted"
    end
    load_all_accounts
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_accounts_path }
    end
  end

  def account_params
    params.require(:account).permit( [:name, :is_admin, :email] )
  end

  def default_colspan
    3
  end

  def namespace
    "admin/" 
  end
end


