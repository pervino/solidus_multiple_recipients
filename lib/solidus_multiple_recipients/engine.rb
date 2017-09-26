module SolidusMultipleRecipients
  class Engine < Rails::Engine
    engine_name "solidus_multiple_recipients"

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      ['app', 'lib'].each do |dir|
        Dir.glob(File.join(File.dirname(__FILE__), "../../#{dir}/**/*_decorator*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end

      # Spree::Order.register_line_item_comparison_hook(:customizations_match)
    end

    config.to_prepare &method(:activate).to_proc

    config.after_initialize do | |
      config.spree.stock_splitters << Spree::Stock::Splitter::Recipient
    end
  end
end
