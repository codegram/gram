require 'spec_helper'

module Gram
  describe Ssh do
   
    describe ".paste" do
      it 'pastes a post to a peer' do
        subject.stub(:get_peers).and_return({"josepjaume" => "192.168.1.55.55"})
        subject.stub(:system)
        subject.should_receive(:system).with("pbpaste | ssh josepjaume@192.168.1.55.55 pbcopy")

        subject.paste 'josepjaume'
      end
    end

    describe ".broadcast" do
      it 'pastes a post to every peer' do
        subject.stub(:get_peers).and_return({"josepjaume" => "192.168.1.55.55", "oriol" => "192.168.1.55.54"})

        subject.should_receive(:paste).with("josepjaume")
        subject.should_receive(:paste).with("oriol")

        subject.broadcast
      end
    end

  end
end
