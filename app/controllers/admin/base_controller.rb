class Admin::BaseController < ApplicationController

  before_action :authenticate_current_account!

  def authenticate_current_account!
    if !current_account || !(current_account.is_admin?)
      flash[:error] = "Not authorized"
      redirect_to root_path
    end
  end

end

