module Api
  module V1
    class WorkersController < ApplicationController
      def create
        worker = Worker.create!(worker_params)
        render json: worker, status: :created
      end

      def destroy
        Worker.find(params[:id]).destroy
        head :no_content
      end

      private

      def worker_params
        params.permit(:name, :company_name, :email, :sort)
      end
    end
  end
end
