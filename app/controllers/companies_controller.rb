class CompaniesController < ApplicationController
  before_action :set_context

  def index
    @companies = Company.all.page(params[:page] || 1).per(10)
  end

  def show
    @company = Company.find(params[:id])
  end

  private

  def set_context
    @total_companies = Company.all.size
  end
end
