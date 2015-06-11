class HelpsController < ApplicationController
  def support
    
  end
  
  def user_manual
    send_file 'docs/SOMAGuide.pdf', :type => 'application/pdf; charset=utf-8'
  end
end
