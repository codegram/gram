require 'spec_helper'

module Gram
  describe Blog do

    before do
      File.stub(:exists?).and_return true
      File.stub(:read).and_return "token: 29384728937598"
    end
   
    describe ".upload" do
      it 'parses the file' do
        subject::Parser.should_receive(:parse).with("my_post.md")
        expect {
          subject.upload("my_post.md")
        }.to raise_error(RestClient::InternalServerError)
      end
      it 'sends a post request' do
        post = double :post
        token = double :token
        response = double :response, code: 201, body: 'ok'
        subject.stub(:get_token).and_return token
        subject::Parser.stub(:parse).with("my_post.md").and_return post

        RestClient.should_receive(:post).with("http://codegram.com/api/posts", token: token, post: post).and_return response

        subject.upload("my_post.md")
      end
    end

    describe ".download" do
      it 'gets the posts' do
        RestClient.stub(:get)
        JSON.should_receive(:parse).and_return [ { "post" => {
                                                      "title"   => "My title",
                                                      "tagline" => "My tagline",
                                                      "cached_slug" => "my-post",
                                                      "body" => "#Hello world"
                                                  } } ]

        file = double(:file)
        File.should_receive(:open).with('my-post.markdown', 'w').and_yield file
        file.should_receive(:write).with """
---
title: My title
tagline: My tagline
---
        """.strip
        file.should_receive(:write).with "\n\n"
        file.should_receive(:write).with "#Hello world"
        file.should_receive(:write).with "\n"

        subject.download
      end
    end

  end
end
