require 'spec_helper'

module Gram
  module Blog
    describe Parser do
      
      describe ".parse" do
        it 'converts a file into a hash' do
          file = double :file
          raw = """
---
title: My title
tagline: My tagline
published: false
---

#My post
#
Blah
          """
          File.stub(:read).with(file).and_return raw

          subject.parse(file).should == { 'title' => 'My title',
                                          'tagline' => 'My tagline',
                                          'published' => false,
                                          'body' => "#My post\n#\nBlah"}
        end
      end

    end
  end
end
