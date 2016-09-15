class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_footprint
  before_action :set_section
  before_action :set_search_config

  private

  def set_footprint
    @date_modified = Tender.by_date_modified.first.try(:date_modified)
  end

  def set_section
    @section = self.class.name.remove('Controller').downcase
  end

  def set_search_config
    @search_placeholder = 'Назва або номер закупівлі, назва або код ЄДРПОУ компанії'
    @search_action_path = tenders_path
  end
end
