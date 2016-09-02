module ApplicationHelper
  def currency_format(currency)
    { 'UAH' => 'грн.' }[currency]
  end

  def tender_status(status)
    OpenProcurement::Constants::TENDER_STATUS_OPTIONS[status]
  end

  def tender_status_class(status)
    {
      'active.tendering' => 'primary',
      'unsuccessful'     => 'error', # 'warning',
      'complete'         => 'success',
      'cancelled'        => 'error',
    }[status] || ''
  end
end
