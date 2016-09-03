module ApplicationHelper
  def currency_format(currency)
    { 'UAH' => 'грн.' }[currency]
  end

  def tender_status(status)
    OpenProcurement::Constants::TENDER_STATUS_OPTIONS[status]
  end

  def tender_status_class(status)
    status = status.split('.').first
    {
      'active'   => 'success',
      'complete' => 'primary'
      #'unsuccessful' => 'error', # 'warning',
      #'cancelled'    => 'error',
    }[status] || ''
  end

  def amount(value, currency)
    currency = currency_format(currency)
    number_to_currency(value, unit: currency)
  end

  def tax_label(value)
    value ? 'з ПДВ' : 'без ПДВ'
  end

  def tender_json_path(id)
    "http://api.openprocurement.org/api/2.3/tenders/#{id}"
  end

  def tender_promua_path(id)
    "http://zakupki.prom.ua/dz/list?search=#{id}"
  end
end
