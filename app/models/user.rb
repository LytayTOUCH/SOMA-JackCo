class User < ActiveRecord::Base
  include UuidHelper

  attr_reader :resource_tokens
  attr_accessor :current_password
  before_create :resource_tokens

  has_many :resource_users, foreign_key: :user_id 
  has_many :resources, through: :resource_users, dependent: :destroy

  # has_and_belongs_to_many :permissions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable
end