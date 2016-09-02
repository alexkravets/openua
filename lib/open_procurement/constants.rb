module OpenProcurement
  module Constants
    TENDER_STATUS_OPTIONS = {
      'active.enquiries'     => 'Період уточнень', #(уточнення)
      'active.tendering'     => 'Прийом пропозицій',
      'active.auction'       => 'Період аукціону',
      'active.pre-qualification' => 'Пре-кваліфікація',
      'active.pre-qualification.stand-still' =>
        'Пре-кваліфікація: період оскарження',
      'active.qualification' => 'Кваліфікація',
      'active.awarded'       => 'Пропозиції розглянуто', #(розглянуто)
      'unsuccessful'         => 'Закупівля не відбулась',
      'complete'             => 'Завершено',
      'cancelled'            => 'Скасовано'
    }.freeze
  end
end

