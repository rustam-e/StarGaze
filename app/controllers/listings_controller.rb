class ListingsController < ApplicationController
    def new
        @listing = Listing.new
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@listing.save)
                f.html {redirect_to ''+ category_path(@listing.category), notice: "Listing created!" }
            else
                f.html {redirect_to "", notice: "Error: Listing not saved."}
            end
        end
    end

    def show
        @listing = Listing.find(params[:id])
        @toFollow = User.all.first(5)
    end
  
    def edit 
        @listing = Listing.find(params[:id]) 
    end
    
    def update
        @listing = Listing.find(params[:id])

        if @listing.update(listing_params)
            redirect_to @listing
        else
            render 'edit'
        end
    end    

    private
    def listing_params #allows certain data to be passed via form.
        params.require(:listing).permit(:user_id, :name, :description, :category_id)
    end
end
