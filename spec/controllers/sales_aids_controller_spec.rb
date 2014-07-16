require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SalesAidsController do

  # This should return the minimal set of attributes required to create a valid
  # SalesAid. As you add validations to SalesAid, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SalesAidsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all sales_aids as @sales_aids" do
      sales_aid = SalesAid.create! valid_attributes
      get :index, {}, valid_session
      assigns(:sales_aids).should eq([sales_aid])
    end
  end

  describe "GET show" do
    it "assigns the requested sales_aid as @sales_aid" do
      sales_aid = SalesAid.create! valid_attributes
      get :show, {:id => sales_aid.to_param}, valid_session
      assigns(:sales_aid).should eq(sales_aid)
    end
  end

  describe "GET new" do
    it "assigns a new sales_aid as @sales_aid" do
      get :new, {}, valid_session
      assigns(:sales_aid).should be_a_new(SalesAid)
    end
  end

  describe "GET edit" do
    it "assigns the requested sales_aid as @sales_aid" do
      sales_aid = SalesAid.create! valid_attributes
      get :edit, {:id => sales_aid.to_param}, valid_session
      assigns(:sales_aid).should eq(sales_aid)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new SalesAid" do
        expect {
          post :create, {:sales_aid => valid_attributes}, valid_session
        }.to change(SalesAid, :count).by(1)
      end

      it "assigns a newly created sales_aid as @sales_aid" do
        post :create, {:sales_aid => valid_attributes}, valid_session
        assigns(:sales_aid).should be_a(SalesAid)
        assigns(:sales_aid).should be_persisted
      end

      it "redirects to the created sales_aid" do
        post :create, {:sales_aid => valid_attributes}, valid_session
        response.should redirect_to(SalesAid.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sales_aid as @sales_aid" do
        # Trigger the behavior that occurs when invalid params are submitted
        SalesAid.any_instance.stub(:save).and_return(false)
        post :create, {:sales_aid => {  }}, valid_session
        assigns(:sales_aid).should be_a_new(SalesAid)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SalesAid.any_instance.stub(:save).and_return(false)
        post :create, {:sales_aid => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested sales_aid" do
        sales_aid = SalesAid.create! valid_attributes
        # Assuming there are no other sales_aids in the database, this
        # specifies that the SalesAid created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        SalesAid.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => sales_aid.to_param, :sales_aid => { "these" => "params" }}, valid_session
      end

      it "assigns the requested sales_aid as @sales_aid" do
        sales_aid = SalesAid.create! valid_attributes
        put :update, {:id => sales_aid.to_param, :sales_aid => valid_attributes}, valid_session
        assigns(:sales_aid).should eq(sales_aid)
      end

      it "redirects to the sales_aid" do
        sales_aid = SalesAid.create! valid_attributes
        put :update, {:id => sales_aid.to_param, :sales_aid => valid_attributes}, valid_session
        response.should redirect_to(sales_aid)
      end
    end

    describe "with invalid params" do
      it "assigns the sales_aid as @sales_aid" do
        sales_aid = SalesAid.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SalesAid.any_instance.stub(:save).and_return(false)
        put :update, {:id => sales_aid.to_param, :sales_aid => {  }}, valid_session
        assigns(:sales_aid).should eq(sales_aid)
      end

      it "re-renders the 'edit' template" do
        sales_aid = SalesAid.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SalesAid.any_instance.stub(:save).and_return(false)
        put :update, {:id => sales_aid.to_param, :sales_aid => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested sales_aid" do
      sales_aid = SalesAid.create! valid_attributes
      expect {
        delete :destroy, {:id => sales_aid.to_param}, valid_session
      }.to change(SalesAid, :count).by(-1)
    end

    it "redirects to the sales_aids list" do
      sales_aid = SalesAid.create! valid_attributes
      delete :destroy, {:id => sales_aid.to_param}, valid_session
      response.should redirect_to(sales_aids_url)
    end
  end

end