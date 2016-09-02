class TendersController < ApplicationController
  def index
    @tenders = Tender.all.page(params[:page] || 1).per(10)
  end

  def show
    id = params[:id]
    @tender = Tender.find_by(open_procurement_id: id)
    @bundle = OpenProcurement::TenderBundle.find_by(open_procurement_id: id)
    @json = JSON.pretty_generate(@bundle.data)
  end

  private

  def client
    @client ||= OpenProcurement::Client.new
  end
end
