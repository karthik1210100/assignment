class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @memberships = current_user.memberships.includes(:organization)
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    if current_user.admin_of?(@membership.organization) && @membership.save
      redirect_to memberships_path, notice: "Member added"
    else
      render :new, alert: "Permission denied or invalid input"
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :organization_id, :role)
  end
end
