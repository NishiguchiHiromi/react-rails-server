module Api
  module V1
    class DepartmentsController < ApplicationController

      def show
        departments = ::Department.all.order(:order)
        render json: departments
      end

      def create
        dept = Api::Department.new
        dept.save!(departments_params[:departments])
        show
      end

      private
  
      def departments_params
        params.permit(departments: [
          :id, :name, :order, children:[
            :id, :name, :order, children:[
              :id, :name, :order, children:[
                :id, :name, :order, children:[
                  :id, :name, :order, children:[
                    :id, :name, :order, children:[
                      :id, :name, :order, children:[
                        :id, :name, :order, children:[
                          :id, :name, :order, children:[
                            :id, :name, :order,
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]).to_h.deep_symbolize_keys
      end
    end    
  end
end