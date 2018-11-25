class UsersController < ApplicationController
  respond_to :html, :json
  def show
    @user = User.find(params[:id])
    @filterrific = initialize_filterrific(
      Lection,
      params[:filterrific],
      select_options: {
        :sorted_by => @user.lections.options_for_sorted_by
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [
        :sorted_by,
        :search_query,
        :with_speciality],
        sanitize_params: true
        ) or return
        @lections = @filterrific.find.page(params[:page])
        respond_to do |format|
          format.html
          format.js
        end

      rescue ActiveRecord::RecordNotFound => e
        # There is an issue with the persisted param_set. Reset it.
        puts "Had to reset filterrific params: #{ e.message }"
        redirect_to(reset_filterrific_url(format: :html)) and return
      end

      def update
        @user = User.find(params[:id])
        params.permit!
        @user.update_attributes(params[:user])
        respond_with @user
      end

    end
