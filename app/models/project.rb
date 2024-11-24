class Project < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :project_lead, presence: true
  validates :todo_list, presence: true
  validates :participants, presence: true
  validates :document_storage, presence: true

end
