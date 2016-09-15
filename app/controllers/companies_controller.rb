class CompaniesController < ApplicationController
  def index
    @search = params[:search]
    @chain = Company.all

    if @search.present?
      @chain = @chain.search(@search, match: :all)
    end

    @companies = @chain.page(params[:page] || 1).per(15)
  end

  def show
    @company = Company.find_by(company_id: params[:id])
  end

  def set_search_config
    @search_placeholder = 'Назва або код ЄДРПОУ компанії'
    @search_action_path = companies_path
  end
end
