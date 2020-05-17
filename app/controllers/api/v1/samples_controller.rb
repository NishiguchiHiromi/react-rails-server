module Api
  module V1
    class SamplesController < ApplicationController
      skip_before_action :check_custom_header
      skip_before_action :require_login

      def show
        render json: { ok: "OK!" }
      end
    end    
  end
end
