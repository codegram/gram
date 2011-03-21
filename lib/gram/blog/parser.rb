require 'yaml'

module Gram
  module Blog
    module Parser
      class << self

        def parse(file)
          raw_content = File.read(file)
          headers = raw_content.match(/---(.*)---/m)
          yaml = YAML.load($1.strip)

          content = raw_content.gsub(/---.*---/m, '').strip

          yaml.update({ 'body' => content })
        end

      end
    end
  end
end
