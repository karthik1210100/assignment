class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy analytics]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update, :destroy, :analytics]

  def index
    @organizations = current_user.organizations
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      Membership.create(user: current_user, organization: @organization, role: 'admin')
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization updated.'
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path, notice: 'Organization deleted.'
  end

  def analytics
    @member_count = @organization.users.count
    @age_distribution = @organization.users.group(:age).count
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def authorize_user!
    membership = current_user.memberships.find_by(organization: @organization)
    redirect_to root_path, alert: "Not authorized" unless membership&.role == 'admin'
  end
end
