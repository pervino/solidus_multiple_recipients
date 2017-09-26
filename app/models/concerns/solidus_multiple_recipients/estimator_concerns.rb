module SolidusMultipleRecipients
  module EstimatorConcerns
    extend ActiveSupport::Concern

    included do
      prepend(InstanceMethods)
    end

    module InstanceMethods
      def shipping_methods(package)
        package.shipping_methods
          .available_for_address(package.shipment.address)
          .includes(:calculator, tax_category: :tax_rates)
          .to_a
          .select do |ship_method|
          calculator = ship_method.calculator
          calculator.available?(package) &&
            (calculator.preferences[:currency].blank? ||
             calculator.preferences[:currency] == package.shipment.order.currency)
        end
      end
    end
  end
end
