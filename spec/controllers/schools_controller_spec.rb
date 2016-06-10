require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:school) { FactoryGirl.create(:school)}

  describe "GET #index" do
    before(:each) do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the schools instance variable' do
      expect(assigns(:schools)).to eq([])
    end

    it 'render the index template' do
      expect(response).to render_template(:index)
    end

    it 'has schools in the school instance variable' do
      5.times { |index| School.create(name: "name_#{index}", year: '2016', mascot: 'bear')}
      expect(assigns(:schools).length).to eq(5)
      expect(assigns(:schools).last.name).to eq('name_4')
    end
  end

  describe "GET #show" do
    before (:each) do
      get :show, id: school.id
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'sets the user instance varible' do
      expect(assigns(:school).name).to eq(school.name)
    end
  end

  describe "GET #new" do
    before (:each) do
      get :new
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it 'set the school in the instance variable' do
      expect(assigns(:school)).to_not eq(nil)
    end
  end

  describe "POST #create" do
    before (:each) do
      @school_params = {
         school: FactoryGirl.attributes_for(:school)
       }
       post :create, @school_params
    end

    it 'sets the school instance variable' do
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school).name).to eq(@school_params[:school][:name])
    end

    it 'creates a new school' do
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(@school_params[:school][:name])
    end

    it 'redirects to the show on success' do
      expect(response).to redirect_to(school_path(School.first))
    end

    it 'renders the new template on fail' do
      expect(School.count).to eq(1)
      post :create, { school: {name: ''}}
      expect(School.count).to eq(1)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) do
      get :edit, id: school.id
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end

    it 'sets school instance variable' do
      expect(assigns(:school).id).to eq(school.id)
    end
  end

  describe "PUT #update" do
    it 'sets the school instance variable' do
      put :update, {id: school.id, school: {name: 'new name'}}
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school)).to eq(school)
    end

    it 'updates the school' do
      put :update, {id: school.id, school: {name: 'new name'}}
      expect(school.reload.name).to eq('new name')
    end

    it 'redirects to the show on success' do
      put :update, {id: school.id, school: {name: 'new name'}}
      expect(response).to redirect_to(school_path(School.first))
    end

    it 'renders the edit template on fail' do
      put :update, {id: school.id, school: {name: ''}}
      expect(response).to render_template(:edit)
    end

    it 'sets the flash success on update' do
      put :update, {id: school.id, school: {name: 'new name'}}
      expect(flash[:success]).to eq('The school has been updated successfully!')
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      delete :destroy, id: school.id
    end
    it 'sets the school instance variable' do
    expect(assigns(:school)).to eq(school)
    end

    it 'destroys the school successfully' do
      expect(School.count).to eq(0)
    end

    it 'redirects to the index path after destroy' do
      expect(response).to redirect_to(schools_path)
    end
  end
end
