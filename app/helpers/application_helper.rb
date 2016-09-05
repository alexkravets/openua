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

  def tender_prozorro_path(id)
    "https://prozorro.gov.ua/tender/#{id}/"
  end

  def tender_document_type(type)
    OpenProcurement::Constants::TENDER_DOCUMENT_TYPE_OPTIONS[type] || '—'
  end

  def documents_in_groups(documents)
    groups = {}
    documents.each do |d|
      groups[d.open_procurement_id] ||= []
      groups[d.open_procurement_id] << d
    end
    groups
  end

  def document_preview_path(document)
    "//docs.google.com/viewer?url=#{document.url}" # ?embedded=true&
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
