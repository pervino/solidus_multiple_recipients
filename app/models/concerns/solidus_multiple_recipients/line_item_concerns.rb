module SolidusMultipleRecipients
  module LineItemConcerns
    extend ActiveSupport::Concern

    included do
      has_one :recipient
      has_one :recipient_address, through: :recipient, source: :address
    end

  end
end
