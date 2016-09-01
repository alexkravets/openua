class TendersController < ApplicationController
  def index
    response = client.tenders
    @next_page = response['next_page']
    @tenders = response['data']
  end

  def show
    id = params[:id]
    json = client.tender(id)
    @json = JSON.pretty_generate(json)
  end

  private

  def client
    @client ||= OpenProcurement::Client.new
  end
end
