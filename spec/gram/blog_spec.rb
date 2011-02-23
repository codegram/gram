require 'spec_helper'

module Gram
  describe Blog do

    before do
      File.stub(:exists?).and_return true
    end
   
    describe ".run" do
      it 'parses the file' do
        subject::Parser.should_receive(:parse).with("my_post.md")
        expect {
          subject.run("my_post.md")
        }.to raise_error(RestClient::InternalServerError)
      end
      it 'sends a post request' do
        post = double :post
        token = double :token
        response = double :response, code: 201, body: 'ok'
        subject.stub(:get_token).and_return token
        subject::Parser.stub(:parse).with("my_post.md").and_return post

        RestClient.should_receive(:post).with("http://codegram.com/api/posts", token: token, post: post).and_return response

        subject.run("my_post.md")
      end
    end

  end
end
