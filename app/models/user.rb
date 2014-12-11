class User < ActiveRecord::Base
  include UuidHelper
  # rolify
  attr_reader :resource_tokens
  before_create :resource_tokens

  has_many :resource_users, foreign_key: :user_id 
  has_many :resources, through: :resource_users
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  def resource_tokens=(ids)
    puts "================************================"
    resource_ids = ids.split(",")
  end
         
end