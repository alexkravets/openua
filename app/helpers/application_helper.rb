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
end
