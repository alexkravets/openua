class Contact
  include Mongoid::Document

  ## Attributes
  field :name
  field :email
  field :telephone
  field :fax_number
  field :url

  ## Relations
  belongs_to :company
end
