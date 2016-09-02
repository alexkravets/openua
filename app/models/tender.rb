class Tender
  include Mongoid::Document

  ## Attributes
  field :open_procurement_id
  ### Generic
  field :tender_id
  field :title
  field :description
  field :status
  field :date, type: DateTime
  field :date_modified, type: DateTime
  ### Value
  field :value_amount, type: Float
  field :value_currency
  field :value_value_added_tax_included
  ### Tender Period
  field :tender_start_date, type: DateTime
  field :tender_end_date, type: DateTime
  ### Enquiry Period
  field :enquiry_start_date, type: DateTime
  field :enquiry_end_date, type: DateTime
  ### Procuring Entity
  field :procuring_entity_name

  ## Validations
  validates :open_procurement_id, presence: true

  def self.bundle_update(b)
    t = self.find_or_create_by(open_procurement_id: b.open_procurement_id)
    data = b.data

    ### Generic
    t.tender_id     = data['tenderID']
    t.title         = data['title']
    t.description   = data['description']
    t.status        = data['status']
    t.date_modified = data['dateModified']
    t.date          = data['date']

    ## Value
    t.value_amount                   = data['value']['amount']
    t.value_currency                 = data['value']['currency']
    t.value_value_added_tax_included = data['value']['valueAddedTaxIncluded']

    ### Tender Period
    if data['tenderPeriod']
      t.tender_start_date = data['tenderPeriod']['startDate']
      t.tender_end_date   = data['tenderPeriod']['endDate']
    end

    ### Enquiry Period
    if data['enquiryPeriod']
      t.enquiry_start_date = data['enquiryPeriod']['startDate']
      t.enquiry_end_date   = data['enquiryPeriod']['endDate']
    end

    ### Procuring Entity
    t.procuring_entity_name = data['procuringEntity']['name']

    t.save
  end
end
