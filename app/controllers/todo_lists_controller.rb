class TodoListsController < ApplicationController
  before_action :authenticate_user! # Exige login
  before_action :set_todo_list, only: %i[ show edit update destroy ]

  def index
    @todo_lists = current_user.todo_lists # Apenas listas do usuário logado
  end

  def show
  end

  def new
    @todo_list = TodoList.new
  end

  def edit
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params) # Associa ao usuário

    if @todo_list.save
      redirect_to @todo_list, notice: "Todo list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todo_lists/1 or /todo_lists/1.json
  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: "Todo list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/1 or /todo_lists/1.json
  def destroy
    @todo_list.destroy!

    redirect_to todo_lists_path, status: :see_other, notice: "Todo list was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      params.expect(todo_list: [ :title, :description, :user_id ])
    end
end
