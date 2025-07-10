class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :organizations, through: :memberships

  def age_group
    return :under_13 if age < 13
    return :teen if age < 18
    :adult
  end

  def requires_parental_consent?
    age < 13 && !parental_consent
  end

  def admin_of?(organization)
    memberships.find_by(organization: organization)&.role == 'admin'
  end
end

