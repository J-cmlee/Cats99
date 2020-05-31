class CatRentalRequestsController < ApplicationController
    
    def new
        @request = CatRentalRequest.new
        render :new
    end
    
end
