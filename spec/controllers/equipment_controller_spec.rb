require 'spec_helper'

describe EquipmentController do
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

  describe "GET relocation" do
  end
end
