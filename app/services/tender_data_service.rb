class TenderDataService
  def initialize(tender_bundle)
    id = tender_bundle.open_procurement_id
    @tender = Tender.find_or_create_by(open_procurement_id: id)
    @data = tender_bundle.data
  end

  def update!
    update_tender
    update_tender_procuring_entity
    save!
    create_tender_documents
  end

  def update_tender
    d = @data

    ### Generic
    @tender.tender_id     = d['tenderID']
    @tender.title         = d['title']
    @tender.description   = d['description']
    @tender.status        = d['status']
    @tender.date_modified = d['dateModified']
    @tender.date          = d['date']

    ## Value
    @tender.value_amount                   = d['value']['amount']
    @tender.value_currency                 = d['value']['currency']
    @tender.value_value_added_tax_included = d['value']['valueAddedTaxIncluded']

    ### Tender Period
    if d['tenderPeriod']
      @tender.tender_start_date = d['tenderPeriod']['startDate']
      @tender.tender_end_date   = d['tenderPeriod']['endDate']
    end

    ### Enquiry Period
    if d['enquiryPeriod']
      @tender.enquiry_start_date = d['enquiryPeriod']['startDate']
      @tender.enquiry_end_date   = d['enquiryPeriod']['endDate']
    end

    ### Procuring Entity
    @tender.procuring_entity_name = d['procuringEntity']['name']
  end

  def update_tender_procuring_entity
    d = @data

    i      = d['procuringEntity']['identifier']
    a      = d['procuringEntity']['address']
    c      = d['procuringEntity']['contactPoint']
    id     = i['id']
    scheme = i['scheme']

    company = Company.where(scheme: scheme, company_id: id).first

    # TODO: Do we need to update company data?
    unless company
      company = Company.create name:       d['procuringEntity']['name'],
                               ## Identifier
                               company_id: id,
                               scheme:     scheme,
                               legal_name: i['legalName'],
                               uri:        i['uri'],
                               # TODO: Check what this is used for.
                               #additional_identifiers: [],
                               ## Address
                               street_address: a['streetAddress'],
                               locality:       a['locality'],
                               region:         a['region'],
                               postal_code:    a['postalCode'],
                               country_name:   a['countryName']
    end

    ## Contact
    if c
      company_contact_name = c['name'].try(:downcase)

      contact = company.contacts.where(name: company_contact_name).first
      contact ||= Contact.new name: company_contact_name,
                              company: company

      contact.email      = c['email'].try(:downcase)
      contact.telephone  = c['telephone'].try(:downcase)
      contact.fax_number = c['faxNumber'].try(:downcase)
      contact.url        = c['url'].try(:downcase)
      contact.save!

      @tender.procuring_entity_contact_id = contact.id.to_s
    end

    @tender.procuring_entity = company
    @tender.procuring_entity_kind = d['procuringEntity']['kind']
  end

  def save!
    @tender.save!
  end

  def create_tender_documents
    if @data['documents']
      @data['documents'].each do |d|
        if d['documentOf'] == 'tender'
          document_id   = d['id']
          date_modified = Time.parse(d['dateModified'])

          unless Document.where(open_procurement_id: document_id,
                                date_modified: date_modified).exists?
            @tender.documents.create open_procurement_id: document_id,
                                     document_type:       d['documentType'],
                                     title:               d['title'],
                                     description:         d['description'],
                                     format:              d['format'],
                                     url:                 d['url'],
                                     date_published:      d['datePublished'],
                                     date_modified:       date_modified
          end
        end
      end
    end
  end
end
