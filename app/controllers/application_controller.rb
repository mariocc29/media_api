class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :handle_bad_request_exception

  # The `forbidden_exception` method is responsible for raising a 
  # `ForbiddenException` to indicate insufficient permissions, triggering the handle_application_exception method.
  def forbidden_exception
    render json: {code: :forbidden, error: 'Forbidden'}, status: :forbidden
  end

	# The `route_not_found` method is responsible for raising a 
	# `RoutingException` when a route is not found.
  def route_not_found
    render json: {code: :not_found, error: 'Route Not Found'}, status: :not_found
  end

  private

  def handle_bad_request_exception(exception)
    render json: { status: 400, error: "Bad Request", exception: exception.message }, status: :bad_request
  end
end
