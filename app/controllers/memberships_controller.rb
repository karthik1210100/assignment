class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = current_user.memberships.includes(:organization)
  end

  def show
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

  def edit
  end

  def update
    if current_user.admin_of?(@membership.organization) && @membership.update(membership_params)
      redirect_to membership_path(@membership), notice: "Membership updated"
    else
      render :edit, alert: "Permission denied or invalid input"
    end
  end

  def destroy
    if current_user.admin_of?(@membership.organization)
      @membership.destroy
      redirect_to memberships_path, notice: "Membership deleted"
    else
      redirect_to memberships_path, alert: "Permission denied"
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :organization_id, :role)
  end
end
