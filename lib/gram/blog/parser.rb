require 'yaml'

module Gram
  module Blog
    module Parser
      class << self

        def parse(file)
          raw_content = File.read(file)
          headers = raw_content.match(/---(.*)---/m)
          yaml = YAML.load($1.strip)

          title = yaml["title"]
          tagline = yaml["tagline"]

          content = raw_content.gsub(/---.*---/m, '').strip

          { title: title, tagline: tagline, body: content }
        end

      end
    end
  end
end
