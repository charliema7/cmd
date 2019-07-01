class LoginActivitiesController < ApplicationController
  before_action :set_login_activity, only: [:show]

  # GET /login_activities
  # GET /login_activities.json
  def index
    @login_activities = LoginActivity.all
  end

  # GET /login_activities/1
  # GET /login_activities/1.json
  def show
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_login_activity
      @login_activity = LoginActivity.find(params[:id])
    end