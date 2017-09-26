module Spree
  class Recipient < ActiveRecord::Base
    belongs_to :line_item
    belongs_to :address
  end
end
