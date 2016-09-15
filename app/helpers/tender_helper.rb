module TenderHelper
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
    "//docs.google.com/viewer?url=#{document.url}&embedded=true&"
  end

  def gravatar_image_url(email)
    hex = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hex}?s=80&d=mm&r=g"
  end

  def item_unit(unit)
    code = unit['code']
    name = unit['name']
    name || { 'KT' => 'комплект' }[code] || code
  end

  def item_classification(val)
    { 'CPV' => 'ДК 021:2015',
      'ДКПП' => 'ДК 016:2010' }[val] || val
  end

  def item_value_per_unit(value, quantity)
    amount = value['amount']
    currency = currency_format(value['currency'])
    value_per_unit = amount / quantity.to_i
    number_to_currency(value_per_unit, unit: currency, precision: 0)
  end
end
