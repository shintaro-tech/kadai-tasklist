class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:create, :edit, :show, :update, :destroy]

    def index
        @tasks = current_user.tasks.order(id: :desc).all.page(params[:page]).per(10)
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        if @task.save
            flash[:success] = 'タスク が正常に登録されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスク を登録できませんでした'
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            flash[:success] = 'タスク は正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスク は更新されませんでした'
            render :edit
        end
    end
    def destroy
        @task.destroy

        flash[:success] = 'タスク は正常に削除されました'
        redirect_to tasks_url
    end
    
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
    unless @task
        redirect_to root_url
    end
    end
end
