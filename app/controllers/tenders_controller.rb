class TendersController < ApplicationController
  def index
    @search = params[:search]
    @chain = Tender.by_date_modified

    if @search.present?
      @chain = @chain.search(@search, match: :all)
    end

    @tenders = @chain.page(params[:page] || 1).per(15)
  end

  def show
    id = params[:id]
    @tender = Tender.find_by(tender_id: id)
    @company = @tender.procuring_entity
    @contact = Contact.find(@tender.procuring_entity_contact_id)
  end
end
