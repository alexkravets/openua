class TendersController < ApplicationController
  before_action :set_context

  def index
    @tenders = Tender.by_date_modified.page(params[:page] || 1).per(10)
  end

  def show
    id = params[:id]
    @tender = Tender.find_by(open_procurement_id: id)
  end

  private

  def set_context
    @total_tenders = Tender.all.size
  end
end
