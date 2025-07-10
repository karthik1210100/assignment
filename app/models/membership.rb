class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum role: { member: 'member', admin: 'admin' }
end
