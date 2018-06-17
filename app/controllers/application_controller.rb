# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize

  protected

  def authorize
    if request.format !Mime[:HTML]
      authenticate_or_request_with_http_basic do |name, password|
        user = User.find_by(name: name)
        user&.authenticate(password) ? true : false
      end
    else
      redirect_to login_url, notice: 'Please log in' unless User.find_by(id: session[:user_id])
    end
  end
end
