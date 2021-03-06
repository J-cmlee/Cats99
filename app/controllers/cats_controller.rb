class CatsController < ApplicationController
    
    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])

        if @cat
            render :show
        else
            redirect_to cats_url
        end
    end

    def create
        @cat = Cat.new(cat_params)

        if @cat.save
          # show user the cat show page
          redirect_to cat_url(@cat)
        else
          # show user the new cat form
          render :new
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update
        @cat = Cat.find_by(id: params[:id])

        if @cat.update_attributes(cat_params)
            redirect_to cat_url(@cat)
        else
            render :edit
        end
    end

    def destroy
        @cat = Cat.find(params[:id])
        @cat.destroy
        
        redirect_to cats_path
    end

    private
    def cat_params
        params.require(:cat).permit(:name, :birth_date, :color, :description, :sex)
    end

end
