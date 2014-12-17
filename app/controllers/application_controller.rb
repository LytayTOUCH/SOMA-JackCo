class ApplicationController < ActionController::Base
  include ExceptionHandler
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:alert] = "Access denied. You are not authorized to access the requested page."
  #   redirect_to dashboards_path
  # end

  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected
  def after_update_path_for(resource)
    users_path(resource)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:role, :resource_ids)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end


  # #==============Starting flexible cancan==================
  # protected
  # def self.permission
  #   return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
  # end

  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end
 
  # #load the permissions for the current user so that UI can be manipulated
  # def load_permissions
  #   @current_permissions = current_user.permissions.collect{|i| [i.subject_class, i.action]}
  # end

  # namespace 'permissions' do
  #   desc "Loading all models and their related controller methods inpermissions table."
  #   task(:permissions => :environment) do
  #     arr = []
  #     #load all the controllers
  #     controllers = Dir.new("#{Rails.root}/app/controllers").entries
  #     controllers.each do |entry|
  #       if entry =~ /_controller/
  #         #check if the controller is valid
  #         arr << entry.camelize.gsub('.rb', '').constantize
  #       elsif entry =~ /^[a-z]*$/ #namescoped controllers
  #         Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
  #           if x =~ /_controller/
  #             arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
  #           end
  #         end
  #       end
  #     end
   
  #     arr.each do |controller|
  #       #only that controller which represents a model
  #       if controller.permission
  #         #create a universal permission for that model. eg "manage User" will allow all actions on User model.
  #         write_permission(controller.permission, "manage", 'manage') #add permission to do CRUD for every model.
  #         controller.action_methods.each do |method|
  #           if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
  #             name, cancan_action = eval_cancan_action(method)
  #             write_permission(controller.permission, cancan_action, name)
  #           end
  #         end
  #       end
  #     end
  #   end
  # end

  # def eval_cancan_action(action)
  #   case action.to_s
  #   when "index"
  #     name = 'list'
  #     cancan_action = "index" <strong>#let the cancan action be the actual method name</strong>
  #     action_desc = I18n.t :list
  #   when "new", "create"
  #     name = 'create and update'
  #     cancan_action = "create"
  #     action_desc = I18n.t :create
  #   when "show"
  #     name = 'view'
  #     cancan_action = "view"
  #     action_desc = I18n.t :view
  #   when "edit", "update"
  #     name = 'create and update'
  #     cancan_action = "update"
  #     action_desc = I18n.t :update
  #   when "delete", "destroy"
  #     name = 'delete'
  #     cancan_action = "destroy"
  #     action_desc = I18n.t :destroy
  #   else
  #     name = action.to_s
  #     cancan_action = action.to_s
  #     action_desc = "Other: " < cancan_action
  #   end
  #   return name, cancan_action
  # end
 
  # #check if the permission is present else add a new one.
  # def write_permission(model, cancan_action, name)
  #   permission = Permission.find(:first, :conditions => ["subject_class = ? and action = ?", model, cancan_action])
  #   unless permission
  #     permission = Permission.new
  #     permission.name = name
  #     permission.subject_class = model
  #     permission.action = cancan_action
  #     permission.save
  #   end
  # end

end
