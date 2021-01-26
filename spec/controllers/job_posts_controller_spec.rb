require 'rails_helper'
# rails g rspec:controller job_posts --controller-specs --no-request-specs
RSpec.describe JobPostsController, type: :controller do
    describe '#new' do # 👈🏻 describe 'new' starts here 
        context "with signed in user" do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end

            
            it 'render the new template' do
                # Given

                # When
                get(:new)

                # Then
                expect(response).to(render_template(:new)) #👈🏻 We wverify that the response will render out the tempalte called 'new' using the matcher 'render_template'
                # response is an object that re-presents the HTTP- Response
                # Rspec makes this opbejct available within the specs
            end
            it 'sets an instance variable with new job posts' do
                # Given
                # When
                get(:new)
                # Then
                expect(assigns(:job_post)).to(be_a_new(JobPost))
                # assign(:job_past) is available from the 'rail-controller-testing'. this allows you to grab an instance varaibale, it takes symbol(:job_post)- the name of instance varaible
                # All models are available to controllers 
            end 
        end
    end# 👈🏻 describe 'new' ends  here 
    describe '#create' do# 👈🏻 describe 'create' starts here 
        def valid_request
            post(:create, params:{job_post: FactoryBot.attributes_for(:job_post)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do # 👈🏻 Context Valid Parameters - Start
                it 'creates a job post in the database' do
                    # Given
                    count_before = JobPost.count
                    # When
                    valid_request
                    
                    # job_post:{
                    #     title: 'senior dev',
                    #     description: 'lots of pay',
                    #     location: 'remote',
                    #     min_salary:500_000,
                    #     max_salary:1_000_000
                    # }
                    #Then
                    count_after=JobPost.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that post' do
                    # Given
                    # When
                    valid_request
                    
                    # Then 
                    job_post=JobPost.last
                    expect(response).to(redirect_to(job_post_url(job_post.id)))
                end
            end# 👈🏻 Context Valid Parameters - End
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{job_post: FactoryBot.attributes_for(:job_post, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = JobPost.count
                    invalid_request
                    count_after = JobPost.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    # Given
                    # when
                    invalid_request
                    #then
                    expect(response).to render_template(:new)
                end
            end
        end# 👈🏻 context 'with user signed in' ends here
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                #given
                # User is not signed 
                #when
                valid_request
                #then
                expect(response).to redirect_to(new_session_path)
            end
        end
    end# 👈🏻 describe 'create' ends here 
    describe '#show' do# 👈🏻 describe 'show' start here 
        it 'render show template' do
            # Given
            job_post=FactoryBot.create(:job_post)
            # When
            get(:show, params:{id: job_post.id})
            # Then
            expect(response).to render_template(:show)
        end
        it 'set an instance variable @job_post for the shown object' do
            # Given
            job_post=FactoryBot.create(:job_post)
            # When
            get(:show, params:{id: job_post.id})
            # Then
            expect(assigns(:job_post)).to(eq(job_post))
            
        end
    end# 👈🏻 describe 'show' ends here 
    describe '#index' do # 👈🏻 describe 'index' starts here 
        it 'render the index template' do
            #given
            #when
            get(:index)
            #then
            expect(response).to render_template(:index)
        end
        it 'assign an instance variable @job_posts which contains all created job posts' do
            # Given
            job_post_1=FactoryBot.create(:job_post)
            job_post_2=FactoryBot.create(:job_post)
            job_post_3=FactoryBot.create(:job_post)
            # When
            get(:index)
            # Then
            expect(assigns(:job_posts)).to eq([job_post_3, job_post_2,job_post_1])
        end
    end# 👈🏻 describe 'index' ends here 
    describe "# edit" do# 👈🏻 describe 'edit' starts here 
        context "with signed in user" do
            context " as owner" do
                before do
                    # session[:user_id]=FactoryBot.create(:user)
                    current_user=FactoryBot.create(:user)
                    session[:user_id]= current_user.id
                    @job_post=FactoryBot.create(:job_post, user: current_user)
                end
                it "render the edit template" do
                    # Given
                    
                    #When
                    get(:edit, params:{id: @job_post.id})
                    # then
                    expect(response).to render_template :edit
                end
            end
            context 'as non owner' do
                before do
                    current_user=FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @job_post=FactoryBot.create(:job_post)
                end
                it 'should redirect to the show page' do
                    get(:edit, params:{id:@job_post.id})
                    expect(response).to redirect_to job_post_path(@job_post)
                end
            end
        end
    end# 👈🏻 describe 'edit' ends here 
    describe '#update' do# 👈🏻 describe 'update' starts here 
        before do
            #given
            @job_post= FactoryBot.create(:job_post)
        end
        context "with signed in user"do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context "with valid parameters" do
                it "update the job post record with new attributes" do

                    #when
                    new_title = "#{@job_post.title} plus some changes!!!"
                    patch(:update, params:{id: @job_post.id, job_post:{title: new_title}})
                    #then
                    expect(@job_post.reload.title).to(eq(new_title))
                end
                it 'redirect to the show page' do
                    new_title = "#{@job_post.title} plus some changes!!!"
                    patch(:update, params:{id: @job_post.id, job_post:{title: new_title}})
                    expect(response).to redirect_to(@job_post)

                end
            end
            context 'with invalid parameters' do 
                it 'should not update the job post record' do
                    patch(:update, params:{id: @job_post.id, job_post: {title: nil}})
                    job_post_after_update = JobPost.find(@job_post.id)
                    expect(job_post_after_update.title).to(eq(@job_post.title))
                end
            end
        end 
    end# 👈🏻 describe 'update' ends here 
    describe '#destroy' do
        context "with signed in user" do
            context 'as owner' do
                before do
                    #given
                    # As given we have already created rights / ability in ability.rb
                    # Here we need a user who is also an owner of the job_post 
                    # so he can delete that job_pos
                    current_user=FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @job_post=FactoryBot.create(:job_post, user: current_user)
                    #when
                    delete(:destroy, params:{id: @job_post.id})
                end
                it 'remove job post from the db' do
                    #then 
                    expect(JobPost.find_by(id: @job_post.id)).to(be(nil))
                end
                it 'redirect to the job post index' do
                    expect(response).to redirect_to(job_posts_path)
                end
                it 'set a flash message' do
                    expect(flash[:danger]).to be
                end 
            end
            context "as non owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @job_post=FactoryBot.create(:job_post)
                end
                it 'does not remove the job post' do
                    delete(:destroy,params:{id: @job_post.id})
                    expect(JobPost.find(@job_post.id)).to eq(@job_post)
                end
            end
        end
    end
end
