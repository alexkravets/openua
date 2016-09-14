class Company
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  ## Attributes
  field :name
  ### Identifier
  field :scheme
  field :company_id
  field :legal_name
  field :uri
  field :additional_identifiers, type: Array
  ## Address
  field :street_address
  field :locality
  field :region
  field :postal_code
  field :country_name

  ## Relations
  has_many :contacts
  has_many :tenders, inverse_of: :procuring_entity

  ## Search
  search_in :name, :company_id
end
