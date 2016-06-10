require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:school) { FactoryGirl.create(:school)}
  let(:classroom) { FactoryGirl.create(:classroom, school_id: school.id)}
  let(:classroom2) { FactoryGirl.create(:classroom, school_id: school.id)}

  describe "GET #index" do
    it "returns http success" do
      get :index, school_id: school.id
      expect(response).to have_http_status(:success)
    end

    it 'sets the classrooms instance var' do
      get :index, school_id: school.id
      expect(assigns(:classrooms)).to eq([])
    end

    it 'render the index template' do
      get :index, school_id: school.id
      expect(response).to render_template(:index)
    end
    #test not working
    it 'has classrooms in the classroom instance var' do
      school
      classroom
      classroom2
      get :index, school_id: school.id
      expect(assigns(:classrooms).length).to eq(2)
      expect(assigns(:classrooms).last.name).to eq(classroom2.name)
    end
  end


  describe "GET #show" do
    before (:each) do
      get :show, school_id: school.id, id: classroom.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to have_http_status(:success)
    end

    it 'sets the user instance variable' do
      expect(assigns(:classroom).name).to eq(classroom.name)
    end
  end

  describe "GET #new" do
    before (:each) do
      get :new, school_id: school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "reders the new template" do
      expect(response).to render_template(:new)
    end

    it "set the class in the instance var" do
      expect(assigns(:classroom)).to_not eq(nil)
    end
  end

  describe "POST #create" do
    before (:each) do 
      @classroom_params = {school_id: school.id, classroom:
                            { name: 'new class', size: 51
                            }
                          }
      post :create, @classroom_params
    end

    it 'sets the school instance variable' do
      expect(assigns(:classroom)).to_not eq(nil)
      expect(assigns(:classroom).name).to eq(@classroom_params[:classroom][:name])
    end

    it 'creates a new school' do
      expect(Classroom.count).to eq(1)
      expect(Classroom.first.name).to eq(@classroom_params[:classroom][:name])
    end

    it 'redirect to the show on success' do
      expect(response).to redirect_to(school_classroom_path(assigns(:school), (assigns(:classroom))))
    end

    it 'renders the new template on fail' do
      expect(Classroom.count).to eq(1)
      post :create, { school_id: school.id, classroom: {name: ''}}
      expect(Classroom.count).to eq(1)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before (:each) do
      get :edit, school_id: school.id, id: classroom.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end

    it "set the class in the instance var" do
      expect(assigns(:classroom).id).to eq(classroom.id)
    end
  end

  describe "PUT #update" do
    it 'sets the school instance var' do
      put :update, { school_id: school.id, id: classroom.id, classroom: {name: 'new name'}}
      expect(assigns(:classroom)).to_not eq(nil)
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'updates the classroom' do
      put :update, { school_id: school.id, id: classroom.id, classroom: {name: 'new name'}}
      expect(classroom.reload.name).to eq('new name')
    end

    it 'redirect to the show on success' do
      put :update, { school_id: school.id, id: classroom.id, classroom: {name: 'new name'}}
      expect(response).to redirect_to(school_classroom_path(assigns(:school), (assigns(:classroom))))
    end

    it 'renders the edit template on fail' do
      put :update, { school_id: school.id, id: classroom.id, classroom: {name: ''}}
      expect(response).to render_template(:edit)
    end

    it 'sets the flash success on update' do
      put :update, { school_id: school.id, id: classroom.id, classroom: {name: 'new name'}}
      expect(flash[:success]).to eq('Class has been updated')
    end
  end

  describe "DELETE #destroy" do
    before (:each) do
      delete :destroy, school_id: school.id, id: classroom.id
    end

    it 'sets the school instance var' do
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'destroys the school successfully' do
      expect(Classroom.count).to eq(0)
    end

    it 'redirect to the index path after destroys' do
      expect(response).to redirect_to(school_classrooms_path(assigns(:school)))
    end
  end

end
