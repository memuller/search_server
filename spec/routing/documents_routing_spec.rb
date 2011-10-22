require "spec_helper"

describe DocumentsController do
  describe "routing" do

    describe "as a child of sites" do
      it { get("/site_id/").should route_to("documents#index", site_id: 'site_id') }

      it { get("/site_id/id").should route_to("documents#show", site_id: 'site_id', id: 'id' )}

      it { get("/site_id/id/edit").should route_to("documents#edit", site_id: 'site_id', id: 'id') }

      it { post("/site_id").should route_to("documents#create", site_id: 'site_id') }

      it { put("/site_id/id").should route_to("documents#update", site_id: 'site_id', id: 'id') }

      it { delete("/site_id/id").should route_to("documents#destroy", site_id: 'site_id', id: 'id') }

      it "paginates" do
        get('/site_id/page/2').should route_to("documents#index", page: '2', site_id: 'site_id')
      end
    end

    it "routes to #index" do
      get("/documents").should route_to("documents#index")
    end

    it "routes to #new" do
      get("/documents/new").should route_to("documents#new")
    end

    it "paginates" do
      get("/documents/page/1").should route_to("documents#index", page: "1")
    end

  end
end
