class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Attributes
  field :open_procurement_id
  field :document_type
  field :title
  field :description
  field :format
  field :url
  field :date_published, type: DateTime
  field :date_modified, type: DateTime
  field :language

  ## Relations
  belongs_to :tender

  ## Scopes
  default_scope -> { asc(:date_modified) }

  ## Indexes
  index({ open_procurement_id: 1 }, background: true)
  index({ open_procurement_id: 1, date_modified: 1 }, background: true)
end
