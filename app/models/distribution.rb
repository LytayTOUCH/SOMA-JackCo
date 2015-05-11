class Distribution < ActiveRecord::Base
  include UuidHelper
  
  has_many :output_distributions
end
