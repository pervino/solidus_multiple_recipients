module Spree
  module Stock
    module Splitter
      class Recipient < Spree::Stock::Splitter::Base
        def split(packages)
          split_packages = []
          packages.each do |package|
            split_packages += split_by_recipient(package)
          end
          return_next split_packages
        end

        private

        def split_by_recipient(package)
          categories = Hash.new { |hash, key| hash[key] = [] }
          package.contents.each do |item|
            # Possibly default to order.ship_address is no recipient_address
            categories[item.line_item.recipient_address] << item
          end
          hash_to_packages(categories)
        end

        def hash_to_packages(categories)
          packages = []
          categories.each do |address, contents|
            package = build_package(contents)
            package.optional_address = address

            packages << package
          end
          packages
        end
      end
    end
  end
end
