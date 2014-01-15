require 'spec_helper'

describe SearchesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', column: :diet
      response.should be_success
    end
    
    context "diet" do
      let(:request) { get 'index', column: :diet }
      it "calls Diet" do
        User.should_receive(:includes).with(:diet).and_return(User)
        User.should_receive(:group).with("diets.name").once.and_return(User)
        User.should_receive(:count).with(:id)
        request
      end
      
    end

    context "gender" do
      let(:request) { get 'index', column: :gender }
      it "calls gender" do
        User.should_receive(:includes).with(nil).and_return(User)
        User.should_receive(:group).with("me_gender").once.and_return(User)
        User.should_receive(:count).with(:id)
        request
      end
      
    end

    context "label" do
      let(:request) { get 'index', column: :straightedgeness }
      it "calls Label" do
        User.should_receive(:includes).with(:label).and_return(User)
        User.should_receive(:group).with("labels.name").once.and_return(User)
        User.should_receive(:count).with(:id)
        request
      end
    end
    
    
  end

end
