module Spree
  module Api
    class CustomizationsController < Spree::Api::BaseController
      before_filter :load_line_item, only: [:update, :destroy]
      before_filter :find_customization, only: [:update, :destroy]

      def update
        authorize! :update, @line_item.order, order_token

        if @customization.update_attributes(customization_params)
          respond_with(@customization, default_template: :show)
        else
          invalid_resource!(@customization)
        end
      end

      def destroy
        authorize! :destroy, @line_item.order, order_token
        @customization.destroy
        respond_with(@customization, status: 204)
      end

      private

      def load_line_item
        @line_item ||= Spree::LineItem.includes(:customizations).find(params[:line_item_id])
        authorize! :update, @line_item.order, order_token
      end

      def find_customization
        id = params[:id].to_i
        @customization = @line_item.customizations.detect { |customization| customization.id == id } ||
            raise(ActiveRecord::RecordNotFound)
      end

      def customization_params
        params.require(:customization).permit(:article_id)
      end
    end
  end
end