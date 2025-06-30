class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: %i[show edit update destroy todo_items]

  def index
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  rescue StandardError => e
    flash[:error] = "Error loading todo lists: #{e.message}"
    @todo_lists = []
  end

  def show
  end

  def new
    @todo_list = current_user.todo_lists.build
  end

  def edit
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)

    if @todo_list.save
      redirect_to todo_list_todo_items_path(@todo_list), notice: "Todo list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_todo_items_path(@todo_list), notice: "Todo list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_list.destroy!
    redirect_to todo_lists_url, notice: "Todo list was successfully destroyed."
  rescue StandardError => e
    flash[:error] = "Error destroying todo list: #{e.message}"
    redirect_to todo_lists_url
  end

  def todo_items
    @todo_items = @todo_list.todo_items
  end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Todo list not found"
    redirect_to todo_lists_url
  end

  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
