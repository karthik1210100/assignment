class ContentController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.age_group
    when :under_13
      @content = Content.where(age_group: 'under_13')
    when :teen
      @content = Content.where(age_group: 'teen')
    else
      @content = Content.where(age_group: 'adult')
    end
  end
end
