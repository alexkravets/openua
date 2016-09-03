class TenderBundlesController < ApplicationController
  def show
    id = params[:id]
    bundle = OpenProcurement::TenderBundle.find_by(open_procurement_id: id)
    render json: bundle.data.to_json
  end
end
