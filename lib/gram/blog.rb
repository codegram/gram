require 'rest-client'

module Gram
  module Blog
    class << self

      def run(*args)
        file = args.first
        raise "File #{file} does not exist." unless File.exists?(file)
        puts "Gram::Blog posting..."
        post = Parser.parse(file)
        response = RestClient.post("http://codegram.com/api/posts", token: get_token, post: post )
        puts "Response Code: #{response.code}"
        puts "Response Body: #{response.body}"
      end

      private

      def get_token
        if File.exists?(File.join(File.expand_path('~'), '.gramrc'))
          YAML.load(File.read(File.join(File.expand_path('~'), '.gramrc')))["token"]
        else
          puts "Can't get Gram token. Please create a ~/.gramrc YAML file with a token key."
          exit(1)
        end
      end

    end
  end
end
