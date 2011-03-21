module Gram
  module Gem

    ACTIONS = { create: { 
                  description: "Creates a new gem with the given NAME",
                  arguments: %w(NAME [--rails]),
                  },
              }

    class << self

      def banner
        out = "Available actions:\n"
        ACTIONS.each_pair do |action, metadata|
          out << "\n\t#{action} #{metadata[:arguments].join(' ')}\t\t#{metadata[:description]}"
        end
        out
      end

      # ACTIONS

      def create(name, *options)
        puts "Gram::Gem generating gem scaffold for #{name}..."
        Generator.new.generate(name, options)
        puts "Generated on ./#{name} :)"
      end

    end
  end
end
