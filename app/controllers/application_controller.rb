class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_footprint

  private

  def set_footprint
    @date_modified = Tender.by_date_modified.first.try(:date_modified)
  end
end
