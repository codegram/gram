require 'spec_helper'

module Gram
  describe Gem do
   
    describe ".create" do
      it 'calls a gem generator' do
        generator = mock(Gem::Generator)
        Gem::Generator.should_receive(:new).and_return generator
        generator.should_receive(:generate).with('my_gem', ['--rails'])

        subject.create 'my_gem', '--rails'
      end
    end

  end
end
