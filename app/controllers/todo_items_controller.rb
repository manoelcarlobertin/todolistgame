class TodoItemsController < ApplicationController
  # Primeiro, garanta que o usuário esteja logado
  before_action :authenticate_user!
  # Depois, execute o método 'set_todo_list' antes das ações listadas
  before_action :set_todo_list

  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  def index
    @todo_items = @todo_list.items # usei o 'alias' lá do 'model todo_list'
  end

  def show;end

  def new
    @todo_item = @todo_list.items.build
  end

  def edit;end

  def create
    @todo_item = @todo_list.items.build(todo_item_params)

    if @todo_item.save
      redirect_to todo_list_items_url(@todo_list), notice: "Todo Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to todo_list_items_url(@todo_list), notice: "Todo item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
      redirect_to todo_list_items_url(@todo_list), notice: "Todo item was successfully destroyed."
  end

  private

  def set_todo_list
    # Aqui usamos a versão SEGURA da busca!
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  rescue ActiveRecord::RecordNotFound
    # Bônus: Tratamento de erro amigável
    redirect_to todo_lists_path, alert: "A lista de tarefas que você procurava não foi encontrada."
  end

  def set_todo_item
    @todo_item = @todo_list.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_list_items_url(@todo_list), alert: "Não há item!"
  end

  def todo_item_params
    params.require(:item).permit(:description, :completed_at)
  end
end
