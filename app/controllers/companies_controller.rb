class CompaniesController < ApplicationController
  def index
    @companies = Company.all.page(params[:page] || 1).per(10)
  end

  def show
    @company = Company.find(params[:id])
  end
end
