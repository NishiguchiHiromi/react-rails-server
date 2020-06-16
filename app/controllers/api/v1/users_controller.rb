module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
      def index
        users = User.order(:id).ransack(params[:q]).result(distinct: true).page(params[:page]).per(params[:per])
        render json: { 
          users: ActiveModel::Serializer::CollectionSerializer.new(users),
          count: users.total_count
        }
      end
  
      def show
        render json: @user
      end
  
      def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render status: 422,  json: { error: user.errors.to_hash(true) }
        end
      end
  
      def update
        if @user.update(user_params)
          render json: @user
        else
          render status: 422,  json: { error: @user.errors.to_hash(true) }
        end
      end
  
      def destroy
        @user.destroy
        render json: @user
      end

      def search_form
        render json: {
          gender: User.genders.map { |k, v| {label: User.genders_i18n[k], value: v}},
          blood_type: User.blood_types.map { |k, v| {label: User.blood_types_i18n[k], value: v}},
          hobby: Hobby.pluck(:name, :id).map { |k, v| {label: k, value: v }},
          department: ::Department.pluck(:name, :id).map { |k, v| {label: k, value: v }}
        }
      end
  
      private
  
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:id, :name, :kana, :mail, :gender, :blood_type, :password, :password_confirmation, hobby_ids:[], department_ids:[])
      end
    end    
  end
end
