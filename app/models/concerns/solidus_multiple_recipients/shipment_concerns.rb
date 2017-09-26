module SolidusMultipleRecipients
  module ShipmentConcerns
    extend ActiveSupport::Concern

    included do
      belongs_to :optional_address, class_name: "Spree::Address"

      prepend(InstanceMethods)
    end

    module InstanceMethods
      def address
        optional_address || order.ship_address
      end
    end
  end
end
