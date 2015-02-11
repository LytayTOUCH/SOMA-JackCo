class User < ActiveRecord::Base
  include UuidHelper

  attr_accessor :current_password

  belongs_to :user_group, foreign_key: :user_group_id
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable
end