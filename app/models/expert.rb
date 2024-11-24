class Expert < ApplicationRecord
  has_and_belongs_to_many :categories
  has_one_attached :image
  has_one_attached :pdf_file 

  
  validates :salutation, presence:true
  validates :location, presence:true
  validates :communicationlanguage, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :natinality, presence:true
  validates :academic_title, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :travel_willingness, presence: true
  validates :biography, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :natinality, presence:true
  validates :telefon_number, presence: true, uniqueness: true


  # Scope for searching by name
  scope :search_by_name, ->(name) {
    where('first_name LIKE ? OR last_name LIKE ?', "%#{name}%", "%#{name}%")
  }

  # Scope for filtering by location
  scope :filter_by_location, ->(location) {
    where(location: location)
  }

  # Scope for filtering by category
  scope :filter_by_category, ->(category_name) {
    joins(:categories).where(categories: { name: category_name })
  }

  scope :apply_filters, ->(params) do
    results = all
    results = results.search_by_name(params[:search]) if params[:search].present?
    results = results.filter_by_location(params[:location]) if params[:location].present?
    results = results.filter_by_category(params[:category]) if params[:category].present?
    results
  end
end
