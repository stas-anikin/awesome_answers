class JobPostsController < ApplicationController
    before_action :authenticate_user!, except:[:index,:show]
    before_action :find_job_post,only:[:show,:update, :destroy, :edit]
    
    def new
        @job_post=JobPost.new
    end
    def create
        @job_post=JobPost.new job_post_params
       
        @job_post.user=current_user
        if @job_post.save
            redirect_to job_post_path(@job_post)
        else
            # byebug
            render :new
        end
    end
    def show
        
    end
    def index
        @job_posts=JobPost.all.order(created_at: :desc)
    end
    # From Ken
    def edit
        # @job_post=JobPost.find params[:id]
        if can?(:edit, @job_post)
            render :edit
        else
            redirect_to job_post_path(@job_post)
        end
    end
    
    def update
        
        if @job_post.update job_post_params
            redirect_to @job_post
        end
    end
    def destroy
        if can?(:delete,@job_post)
            @job_post.destroy
            flash[:danger]= 'deleted job post'
            redirect_to job_posts_path
        else
            flash[:danger]="Access Denied"
            redirect_to job_post_url(@job_post)
        end
    end
    private
    def find_job_post
        @job_post=JobPost.find params[:id]
    end
    def job_post_params
        params.require(:job_post)
        .permit(
            :title,
            :description,
            :min_salary,
            :max_salary,
            :company_name,
            :location)
    end
    
end
