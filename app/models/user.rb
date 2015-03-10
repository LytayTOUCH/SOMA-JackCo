class User < ActiveRecord::Base
  include UuidHelper

  attr_accessor :current_password

  belongs_to :user_group, foreign_key: :user_group_id

  belongs_to :labor, foreign_key: :labor_id

  validates :email, length: { maximum: 60 }, presence: true

  validates :user_group_id, length: { maximum: 36 }, presence: true  

  validates :labor_id, length: { maximum: 36 }, presence: true    
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  scope :find_by_email, -> email { where("email like ?", "%#{email}%") }       
end