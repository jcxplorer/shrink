class User < ActiveRecord::Base
  has_many :projects, :through => :involvements
  has_many :involvements, :dependent => :delete_all

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation,
                  :current_password, :remember_me, :project_ids

  validates_presence_of :name
end
