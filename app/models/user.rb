class User < ActiveRecord::Base
  include UuidHelper
  # rolify
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

  def resource_tokens=(ids)
    puts "================************================"
    resource_ids = ids.split(",")
  end
         
  # scope :get_role?, ->(r) { where("role < ?", r) }
  def is_role?(user)
    admin_role = Role.find(:first, :conditions => ["role = ?", "admin"])
    return user.roles.include?(admin_role)
  end

end