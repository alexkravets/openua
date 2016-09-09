class HomeController < ApplicationController
  def index
    @total_companies = Company.all.size
    @total_tenders = Tender.all.size
    @tenders_create_today = Tender.created_today
  end
end
