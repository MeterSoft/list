class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :categories_order, type: Array
  field :all_tasks_order, type: Array

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable, :confirmable
#
#  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me
#  attr_accessible :email, :first_name, :last_name, :password
  has_many :categories
  has_many :tasks
#  validates :email, :uniqueness => true
#  validates :first_name, :last_name, :email, :password, :presence => true

#  serialize :categories_order, Array
#  serialize :all_tasks_order, Array

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
