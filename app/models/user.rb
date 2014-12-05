class User < ActiveRecord::Base
  include UuidHelper
  # rolify

  has_many :resource_users 
  has_many :resources, through: :resource_users
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable
end