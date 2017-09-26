module SolidusMultipleRecipients
  module AddressConcerns
    extend ActiveSupport::Concern

    included do
      has_one :recipient
    end

  end
end
