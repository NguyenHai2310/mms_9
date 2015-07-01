class Admin::SkillsController < ApplicationController
  before_action :check_admin
  before_action :set_skill, except: [:new, :create, :index]

  def index
    @search = Skill.search params[:q]
    @skills = @search.result.paginate page: params[:page],
                                      per_page: Settings.size_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @skills.to_csv}
    end
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "skill.add"
      redirect_to admin_skills_path
    else
      flash[:error] = t "skill.add"
      render :new
    end
  end

  def edit
  end

  def update
    if @skill.update_attributes skill_params
      flash[:success] = t "skill.updated"
      redirect_to admin_skills_path
    else
      render :edit
    end
  end

  def destroy
    if @skill.destroy
      flash[:success] = t "skill.deleted"
    else
      flash[:danger] = t "skill.fail"
    end
    redirect_to admin_skills_path
  end

  private
  def skill_params
    params.require(:skill).permit :name
  end

  def set_skill
    @skill = Skill.find params[:id]
  end
end
