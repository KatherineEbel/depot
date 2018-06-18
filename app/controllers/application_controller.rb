# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_i18n_local_from_params
  before_action :authorize

  private

  def authorize
    if request.format != 'text/html'
      authenticate_or_request_with_http_basic do |name, password|
        user = User.find_by(name: name)
        user&.authenticate(password) ? true : false
      end
    else
      redirect_to login_url, notice: 'Please log in' unless User.find_by(id: session[:user_id])
    end
  end

  protected

  def set_i18n_local_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

end
