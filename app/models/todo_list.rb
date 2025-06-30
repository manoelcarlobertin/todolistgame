class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy
  # ✅ CORRETO: alias_method cria um apelido para um método, incluindo associações
  alias_method :items, :todo_items
end
