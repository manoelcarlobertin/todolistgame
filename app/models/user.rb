class User < ApplicationRecord
  has_many :todo_lists, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
