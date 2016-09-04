class Alert
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Attributes
  field :tender_id
  field :user_id, type: Integer

  ## Validations
  validates :user_id,   presence: true
  validates :tender_id, presence: true

  ## Indexes
  index user_id: 1
end
