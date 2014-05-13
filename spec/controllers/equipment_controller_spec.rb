require 'spec_helper'

describe EquipmentController do
  let(:item) { FactoryGirl.create(:equipment) }
  before(:each) do
    include Rails.application.routes.url_helpers
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    before(:each) do
      get :index
    end

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "should return a list of equipment" do
      assigns(:equipment).should_not be_nil
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "POST relocation" do
    it "when parameter :new_department_id is empty" do
      post :relocation, id: item.id, new_department_id: [""]
      expect(flash[:danger]).to_not be_nil
      expect(response).to redirect_to action: :index
    end

    it "when new department not exists" do
      post :relocation, id: item.id, new_department_id: ["11100000000"]
      expect(flash[:danger]).to_not be_nil
      expect(response).to redirect_to action: :index
    end

    it "should save relocation" do
      new_department = FactoryGirl.create(:department)
      post :relocation, id: item.id, new_department_id: ["#{new_department.id}"]
      assigns[:relocation].should_not be_new_record
    end
  end
end
