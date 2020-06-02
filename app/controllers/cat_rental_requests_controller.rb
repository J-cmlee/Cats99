class CatRentalRequestsController < ApplicationController
    
    def new
        @request = CatRentalRequest.new
        render :new
    end
    
    def create
        @request = CatRentalRequest.new(request_params)

        if @request.save
          # show user the cat show page
          redirect_to cat_url(@request.cat_id)
        else
          # show user the new rental form
          render :new
        end
    end

    def approve
      #render json: current_cat_rental_request
      current_cat_rental_request.approve!
      redirect_to cat_url(current_cat_rental_request.cat_id)
    end

    def deny
      current_cat_rental_request.deny!
      redirect_to cat_url(current_cat_rental_request.cat_id)
    end

    def current_cat_rental_request
      CatRentalRequest.find_by(id: params[:cat_id])
    end

    private
    def request_params
        params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
    end

end
