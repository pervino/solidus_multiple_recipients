module SolidusMultipleRecipients
  module PackageConcerns
    extend ActiveSupport::Concern

    included do
      attr_accessor :optional_address

      prepend(InstanceMethods)
    end

    module InstanceMethods
      # @return [Spree::Shipment] a new shipment containing this package's
      #   inventory units, with the appropriate shipping rates and associated
      #   with the correct stock location
      def to_shipment
        # At this point we should only have one content item per inventory unit
        # across the entire set of inventory units to be shipped, which has
        # been taken care of by the Prioritizer
        contents.each { |content_item| content_item.inventory_unit.state = content_item.state.to_s }
        
        Spree::Shipment.new(
          order: order,
          stock_location: stock_location,
          inventory_units: contents.map(&:inventory_unit),
          optional_address: optional_address
        )
      end
    end
  end
end
