class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
  end

  def new
    @users = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @task
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
end
