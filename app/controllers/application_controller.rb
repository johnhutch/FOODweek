class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, with: :error_handler
  rescue_from ActionController::RoutingError, with: :error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :error_handler

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def raise_routing_error
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}");
  end

  def error_handler(exception)
    logger.error "Exception message: #{exception}."

    respond_to do |format|
      format.html { render "content/error" }
      format.json { head :not_found }
    end
  end
end
