class TodoItem < ApplicationRecord
  scope :completed, -> { where(completed: true) }
  belongs_to :todo_list
end
