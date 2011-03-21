require 'rest-client'
require 'json'

module Gram
  module Blog

    ACTIONS = { upload: { 
                  description: "Uploads the markdown file with filename FILE",
                  arguments: %w(FILE),
                  },
                download: { 
                  description: "Downloads all blog posts to the current folder.",
                  arguments: %w(),
                  }
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

      def upload(file)
        raise "File #{file} does not exist." unless File.exists?(file)
        puts "Gram::Blog uploading..."
        post = Parser.parse(file)
        response = RestClient.post("http://codegram.com/api/posts", token: get_token, post: post )
        puts "Response Code: #{response.code}"
        puts "Response Body: #{response.body}"
      end

      def download
        posts = JSON.parse(RestClient.get("http://codegram.com/api/posts?token=#{get_token}"))
        posts.each do |post|
          post = post["post"]
          header = """
---
title: #{post["title"]}
tagline: #{post["tagline"]}
---

""".strip
          puts "Downloading #{post["cached_slug"]}.markdown..."
          File.open("#{post["cached_slug"]}.markdown", 'w') do |f|
            f.write header
            f.write "\n\n"
            f.write post["body"]
            f.write "\n"
          end
        end
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
