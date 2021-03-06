class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :show, :update, :destroy, :important]

    def index
        @tasks = current_user.tasks.order(id: :desc).all.page(params[:page]).per(10)
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.build(task_params)
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
    
    def update
        if @task.update(task_params)
            flash[:success] = "正常に更新しました"
            redirect_to @task
        else
            flash.now[:danger] = '重要に追加できませんでした'
            render :edit
        end
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status, :important)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
    unless @task
        redirect_to root_url
    end
    end
end
