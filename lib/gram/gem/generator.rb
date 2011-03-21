require 'thor'
require 'active_support/inflector'

module Gram
  module Gem
    class Generator < Thor
      include Thor::Actions

      source_root File.dirname(__FILE__)

      no_tasks do
        def generate(name, options)
          @rails = true if options.include?("--rails")
          @underscored = name.underscore
          @camelized = name.camelize

          run "bundle gem #{@underscored}"

          remove_file("#{@underscored}/Rakefile")
          template('templates/Rakefile.tt', "#{@underscored}/Rakefile")

          remove_file("#{@underscored}/.gitignore")
          template('templates/gitignore.tt', "#{@underscored}/.gitignore")

          template('templates/Readme.tt', "#{@underscored}/Readme.md")
          template('templates/rvmrc.tt', "#{@underscored}/.rvmrc")

          empty_directory "#{@underscored}/spec"
          template('templates/spec/spec_helper.tt', "#{@underscored}/spec/spec_helper.rb")

          inject_into_file "#{@underscored}/#{@underscored}.gemspec", :after => "s.rubyforge_project = \"#{@underscored}\"" do
            runtime_dependencies = []
            runtime_dependencies << "  s.add_runtime_dependency 'activerecord', '~> 3.0.5'" if rails

            development_dependencies = []
            development_dependencies << "  s.add_runtime_dependency 'sqlite3'" if rails
            development_dependencies += [
              "  s.add_development_dependency 'rspec', '~> 2.5.0'",
              "  s.add_development_dependency 'yard'",
              "  s.add_development_dependency 'bluecloth'" ]

            "\n\n" + runtime_dependencies.join("\n") << "\n\n"<< development_dependencies.join("\n")
          end
        end
      end

      private

      def underscored
        @underscored
      end

      def camelized
        @camelized
      end

      def rails
        @rails
      end
    end
  end
end
