class User < ActiveRecord::Base
  include UuidHelper

  attr_accessor :current_password
  # attr_accessor :email

  belongs_to :user_group, foreign_key: :user_group_id
  belongs_to :labor, foreign_key: :labor_id

  has_many :logs
  has_many :output_tasks

  validates :labor_id, length: { maximum: 36 }, :presence => { message: "Labor is required." }
  validates :user_group_id, length: { maximum: 36 }, :presence => { message: "User group is required." }
  # validates :password_confirmation, length: { maximum: 36 }, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

end