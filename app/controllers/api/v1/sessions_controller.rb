module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :require_login

      def show
        if logged_in?
          render json: { loginUser: current_user }
        else
          render status: 401, json: { status: 'Unauthorized' }
        end
      end

      def create
        # Rails.logger.debug("session!!!!!!!!!!")
        # Rails.logger.debug(session.to_hash)
        # Rails.logger.debug("csrf!!!!!!!!!!")
        # Rails.logger.debug(form_authenticity_token)
        # Rails.logger.debug("csrf!!!!!!!!!!")
        # Rails.logger.debug(form_authenticity_token)
        # Rails.logger.debug("request_forgery_protection_token!!!!!!!!!!")
        # Rails.logger.debug(request_forgery_protection_token)
    
    
        user = User.find_by(mail: session_params[:mail])
        if user&.authenticate(session_params[:password]) && !user.locked?
          login(user)
          render json: { loginUser: current_user }
        else
          user&.increment_sign_in_failed!
          render status: 401, json: { status: 'Unauthorized', message: 'メールアドレスまたはパスワードが違います。' }
        end
      end
  
      def destroy
        logout
        render json: { message: 'ログアウトしました。' }
      end
  
      private

      def login(user)
        user.reset_sign_in_failed_count!
        @current_user = user
        session[:user_id] = user.id
      end

      def logout
        @current_user = nil
        reset_session
      end
  
      def session_params
        params.require(:session).permit(:mail, :password)
      end
    end    
  end
end
