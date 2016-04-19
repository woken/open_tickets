class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @company = Company.find_by(id: params[:id])
    redirect_to dashboards_path unless @company
  end
end
