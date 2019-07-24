module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {errors: e.message}, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: {errors: e.message}, status: :unprocessable_entity
    end

    rescue_from Exceptions::LimitReachedError do |_e|
      render json: {errors: 'Limit Reached'}, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: {errors: e.message}, status: :bad_request
    end

    rescue_from Exceptions::InvalidSortBy do |_e|
      render json: {errors: 'sort_by has invalid value'}, status: :unprocessable_entity
    end
  end
end
