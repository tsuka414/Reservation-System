class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  before_action :this_user, only: [:show, :edit]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def working_employees
    @users = User.includes(:attendances).references(:attendances).where('attendances.started_at IS NOT NULL').where('attendances.finished_at IS NULL')
  end
  
  def import
    if params[:file].blank? 
      flash[:warning] = "CSVファイルが選択されていません。"
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:warning] = "CSVファイルを選択してください。"
    else
      num = User.import(params[:file])
      flash[:success] = "ユーザー情報#{ num.to_s }件をインポートしました。"
    end
    redirect_to users_url
  end
  
  def request_monthly
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: params[:user][:first_day])
    if params[:user][:monthly_confirmation].blank?
      flash[:danger] = "所属長を選択してください。"
      redirect_to @user
    else
      @attendance.monthly_request_status = "申請中"
      @attendance.update_attributes(monthly_params)
      flash[:success] = "1ヶ月分の勤怠承認を申請しました。"
      redirect_to @user
    end
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @overwork_notice = Attendance.where(overwork_request_status: "申請中", confirmation: @user.name).count
    @attendance_notice = Attendance.where(edit_request_status: "申請中", edit_confirmation: @user.name).count
    @monthly_notice = Attendance.where(monthly_request_status: "申請中", monthly_confirmation: @user.name).count
    @superiors = User.where(superior: true).where.not(id: @user.id)
    
    respond_to do |format|
      format.html do
          #html用の処理を書く
      end 
      format.csv do
          #csv用の処理を書く
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(update_user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  

  private
  
    def monthly_params
      params.require(:user).permit(:monthly_confirmation)
    end

    def user_params
      params.require(:user).permit(:name, :email, :department )
    end
    
    def update_user_params
      params.require(:user).permit(:name, :email, :department, :employee_number, :uid, :password, :basic_work_time, :designated_work_start_time, :designated_work_end_time)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
end