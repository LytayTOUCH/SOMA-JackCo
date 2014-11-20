module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_error
      rescue_from ActiveRecord::RecordInvalid, with: :render_error
      
      # rescue_from ActionController::RoutingError, with: :render_not_found
      # rescue_from ActionController::UnknownController, with: :render_not_found
      # rescue_from AbstractController::ActionNotFound, with: :render_not_found
      # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      # rescue_from Timeout::Error, with: :render_unavailable
    end

    # def render_not_found(exception)
    #   respond_to do |format|
    #     format.html { render template: 'errors/404', layout: 'application', status: 404 and return }
    #     format.all { render nothing: true, status: 404 and return}
    #   end
    # end

    def render_error(exception)
      # notify exception
      puts "heeeeeeeeeeeeeeeeeeeeeeeeeeeee"
      render template: 'errors/500', formats: :html, layout: 'application', status: 500 and return
    end

    # def render_unavailable(exception)
    #   notify exception
    #   render_static_file(503)
    # end

    # def render_maintenance(exception)
    #   notify exception
    #   render_static_file(502)
    # end

    # def render_static_file(status)
    #   render "#{Rails.root}/public/#{status}", formats: :html, layout: false, status: status and return
    # end

    # def notify(exception)
    #   ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver if Rails.env.production?
    # end

    # #fix routing error which doesn't work in rails 3.1+
    # def routing_error
    #   raise ActionController::RoutingError.new(params[:path])
    # end
  end
end
