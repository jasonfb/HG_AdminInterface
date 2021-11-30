class Admin::PersonsController < Admin::BaseController
  helper :hot_glue
  include HotGlue::ControllerHelper

  
   
  before_action :account
    
  before_action :load_person, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }



   
  def account
    @account ||= Account.find(params[:account_id])
  end


  def load_person
    @person = Person.find(params[:id])
  end
  

  def load_all_persons
    @persons = Person.page(params[:page])
    
  end

  def index
    load_all_persons
    respond_to do |format|
       format.html
    end
  end

  def new 
    @person = Person.new
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(person_params.dup.merge!(account: @account ) )
    @person = Person.create(modified_params)

    if @person.save
      flash[:notice] = "Successfully created #{@person.name}"
      load_all_persons
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_account_persons_path }
      end
    else
      flash[:alert] = "Oops, your person could not be created."
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
    if @person.update(modify_date_inputs_on_params(person_params))
      flash[:notice] = "Saved #{@person.name}"
    else
      flash[:alert] = "Person could not be saved."
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @person.destroy
    rescue StandardError => e
      flash[:alert] = "Person could not be deleted"
    end
    load_all_persons
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_account_persons_path }
    end
  end

  def person_params
    params.require(:person).permit( [:name] )
  end

  def default_colspan
    1
  end

  def namespace
    "admin/" 
  end
end


