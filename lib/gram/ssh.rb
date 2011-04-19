module Gram
  module Ssh

    ACTIONS = { paste: { 
                  description: "Pastes the current clipboard content to your PEER's clipboard.",
                  arguments: %w(PEER),
                  },
                broadcast: { 
                  description: "Pastes the current clipboard content to all your peers.",
                  arguments: %w(),
                  }
              }

    class << self

      def banner
        out = "Available actions:\n"
        ACTIONS.each_pair do |action, metadata|
          out << "\n\t#{action} #{metadata[:arguments].join(' ')}\t\t#{metadata[:description]}"
        end

        peers = nil
        if File.exists?(File.join(File.expand_path('~'), '.gramrc')) &&
          peers = YAML.load(File.read(File.join(File.expand_path('~'), '.gramrc')))["peers"]
          out << "\nYour peers are currently: #{peers.keys.join(', ')}"
        else
          out << "\nYou don't have any peers on your ~/.gramrc. Please add some!"
        end

        out
      end

      # ACTIONS

      def paste(peer)
        ip = get_peers[peer]
        puts "Gram::SSH posting \"#{`pbpaste`}\" to #{peer} at #{ip}..."
        system("pbpaste | ssh #{peer}@#{ip} pbcopy")
        puts "Ok!"
      end

      def broadcast
        get_peers.keys.each do |peer|
          paste peer
        end
      end

      private

      def get_peers
        if File.exists?(File.join(File.expand_path('~'), '.gramrc')) &&
          peers = YAML.load(File.read(File.join(File.expand_path('~'), '.gramrc')))["peers"]
          peers
        else
          puts "Can't get Gram SSH peers. Please create a ~/.gramrc YAML file with some peers."
          exit(1)
        end
      end

    end
  end
end
