module Api
  module V1
    class WorkOrdersController < ApplicationController
      def index
        work_orders = WorkOrder.for_worker(list_params[:worker_id], list_params[:sort_by])
        render json: work_orders
      end

      def create
        work_order = WorkOrder.create!(work_order_params)
        render json: work_order, status: :created
      end

      def assign_worker
        work_order = WorkOrder.find(params[:id])
        worker = Worker.find(worker_id)
        if work_order.workers << worker
          render json: work_order
        else
          render json: {errors: work_order.errors}
        end
      end

      private

      def work_order_params
        params.permit(:title, :description, :deadline)
      end

      def worker_id
        params.permit(:worker_id).fetch(:worker_id)
      end

      def list_params
        if params[:sort_by] && !WorkOrder::SORTABLE_ATTRIBUTES.include?(params[:sort_by])
          raise Exceptions::InvalidSortBy
        end
        params.permit(:worker_id, :sort_by)
      end
    end
  end
end
