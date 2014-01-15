require 'spec_helper'

describe SearchesController do
  let(:all) { User.all }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', column: :diet
      response.should be_success
    end
    
    it "assigns" do
      get 'index', column: :diet
      expect(assigns(:groups)).to_not be_blank
    end
    
    context "diet" do
      let(:request) { get 'index', column: :diet }
      it "calls Diet" do
        User.should_receive(:preload).with(:diet).and_return(User)
        User.should_receive(:select).with("users.id, diet_id").once.and_return(all)
        all.should_receive(:group_by)
        request
      end
      
    end

    context "gender" do
      let(:request) { get 'index', column: :gender }
      it "calls gender" do
        User.should_receive(:preload).with(nil).and_return(User)
        User.should_receive(:select).with("users.id, me_gender").once.and_return(all)
        all.should_receive(:group_by)
        request
      end
      
    end

    context "label" do
      let(:request) { get 'index', column: :straightedgeness }
      it "calls Label" do
        User.should_receive(:preload).with(:label).and_return(User)
        User.should_receive(:select).with("users.id, label_id").once.and_return(all)
        all.should_receive(:group_by)
        request
      end
    end
    
    
  end

end
