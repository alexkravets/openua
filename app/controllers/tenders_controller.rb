class TendersController < ApplicationController
  def index
    @tenders = Tender.by_date_modified.page(params[:page] || 1).per(15)
  end

  def show
    id = params[:id]
    @tender = Tender.find_by(open_procurement_id: id)
    @company = @tender.procuring_entity
    @contact = Contact.find(@tender.procuring_entity_contact_id)
  end
end
