require 'spec_helper'
require 'fileutils'

require 'action_view'
require 'action_controller'
ActionView::Template::Handlers::ERB::ENCODING_FLAG = ActionView::ENCODING_FLAG

require 'generator_spec/test_case'

module Gram
  module Gem
    describe Generator do
      include GeneratorSpec::TestCase
      destination File.expand_path('../../../../tmp', __FILE__)
      tests Generator

      before(:each) do
        prepare_destination
      end

      after(:each) do
        FileUtils.rm_rf File.expand_path('../../../../tmp', __FILE__)
      end
    
      it 'is a Thor generator' do
        Generator.ancestors.should include(Thor)
      end

      describe ".generate" do
        it 'creates a new gem' do
          FileUtils.chdir File.expand_path('../../../../tmp', __FILE__)
          Generator.new.generate('my_gem', [])
          destination_root.should have_structure {
            directory "my_gem" do
              file "Gemfile"
              file "Rakefile"
              file ".gitignore"
              file ".rvmrc"
              file "Readme.md"
              file "my_gem.gemspec" do
                contains "rspec"
                contains "yard"
                contains "bluecloth"
              end
              directory "lib" do
                file "my_gem.rb"
                directory "my_gem" do
                  file "version.rb"
                end
              end
              directory "spec" do
                file "spec_helper.rb"
              end
            end
          }
        end

        context 'with --rails' do
          it 'creates a new rails-ready gem' do
            FileUtils.chdir File.expand_path('../../../../tmp', __FILE__)
            Generator.new.generate('my_gem', ['--rails'])
            destination_root.should have_structure {
              directory "my_gem" do
                file "Gemfile"
                file "Rakefile"
                file ".gitignore"
                file ".rvmrc"
                file "Readme.md"
                file "my_gem.gemspec" do
                  contains "activerecord"
                  contains "sqlite3"

                  contains "rspec"
                  contains "yard"
                  contains "bluecloth"
                end
                directory "lib" do
                  file "my_gem.rb"
                  directory "my_gem" do
                    file "version.rb"
                  end
                end
                directory "spec" do
                  file "spec_helper.rb" do
                    contains "ActiveRecord"
                  end
                end
              end
            }
          end
        end
      end

    end
  end
end
