class HomeController < ApplicationController
  def index
    @total_companies = Company.all.size
    @total_tenders = Tender.all.size
  end
end
