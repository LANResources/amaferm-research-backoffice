require "spec_helper"

describe SalesAidsController do
  describe "routing" do

    it "routes to #index" do
      get("/sales_aids").should route_to("sales_aids#index")
    end

    it "routes to #new" do
      get("/sales_aids/new").should route_to("sales_aids#new")
    end

    it "routes to #show" do
      get("/sales_aids/1").should route_to("sales_aids#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sales_aids/1/edit").should route_to("sales_aids#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sales_aids").should route_to("sales_aids#create")
    end

    it "routes to #update" do
      put("/sales_aids/1").should route_to("sales_aids#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sales_aids/1").should route_to("sales_aids#destroy", :id => "1")
    end

  end
end
