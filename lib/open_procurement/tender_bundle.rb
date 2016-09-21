module OpenProcurement
  class TenderBundle
    include Mongoid::Document

    ## Attributes
    field :open_procurement_id
    field :date_modified
    field :data, type: Hash, default: {}
    field :data_in_sync, default: false
    field :model_in_sync, default: false

    ## Validations
    validates :open_procurement_id, presence: true
    #validates :date_modified, presence: true

    ## Scopes
    default_scope -> { desc(:date_modified) }
    scope :data_not_in_sync, -> { where(data_in_sync: false) }
    scope :model_not_in_sync, -> { where(model_in_sync: false) }

    ## Indexes
    index({ open_procurement_id: 1 }, background: true)
    index({ date_modified: -1 }, background: true)
    index({ data_in_sync: -1 }, background: true)
    index({ model_in_sync: -1 }, background: true)
  end
end
