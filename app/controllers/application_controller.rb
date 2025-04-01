class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound do |err|
    render json: { status: err.message }, status: :not_found
  end
end
