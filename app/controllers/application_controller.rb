class ApplicationController < ActionController::Base
  private

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end
end
