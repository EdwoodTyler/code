class CoursesController < ApplicationController
	before_action :authorized_user, only: [:new, :create, :update, :edit, :destroy]
  before_action :admin_user, only: :destroy

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course created!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find_by(permalink: params[:permalink])
  end

  def update
    @course = Course.find_by(permalink: params[:permalink])
    if @course.update_attributes(course_params)
      flash[:success] = "Course updated successfully"
      redirect_to courses_url
    else
      render 'edit'
    end
  end

  def index
  	@courses = Course.all.sort_by! { |c| c.name.downcase }
  end

  def show
    @course = Course.find_by(permalink: params[:permalink])
    @courses = Course.all
  end

  def destroy
    Course.find_by(permalink: params[:permalink]).destroy
    flash[:success] = "Course successfully deleted."
    redirect_to courses_url
  end

  private

  	def authorized_user
      if current_user.admin? || current_user.course_creator?
      else
		    redirect_to courses_url, notice: "You do not have the correct privileges to access this page"
      end
		end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def course_params
      params.require(:course).permit(:name, :description, :permalink, :user_id)
    end
end
