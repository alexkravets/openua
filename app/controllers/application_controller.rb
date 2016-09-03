class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_footprint

  private

  def set_footprint
    @total_tenders = Tender.all.size
    @date_modified = Tender.all.first.try(:date_modified)
  end
end
