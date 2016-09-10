module ApplicationHelper
  def currency_format(currency)
    { 'UAH' => '&#8372;'.html_safe }[currency]
  end

  def tender_status(status)
    OpenProcurement::Constants::TENDER_STATUS_OPTIONS[status]
  end

  def tender_status_class(status)
    status = status.split('.').first
    {
      'active'   => 'green',
      'complete' => 'blue'
      #'unsuccessful' => 'error', # 'warning',
      #'cancelled'    => 'error',
    }[status] || ''
  end

  def amount(value, currency='')
    currency = currency_format(currency)
    number_to_currency(value, unit: currency, precision: 0)
  end

  def tax_label(value)
    value ? 'з ПДВ' : 'без ПДВ'
  end

  def dt(datetime)
    l(datetime.in_time_zone, format: '%-d %b %H:%M').downcase
  end

  def address(company)
    index    = company.postal_code
    contry   = company.country_name
    region   = company.region
    locality = company.locality
    street   = company.street_address

    "#{street} / #{locality}<br/>#{region} / #{contry} / #{index}".html_safe
  end

  def lf(url)
    url.remove('http://').remove('https://')
  end
end
