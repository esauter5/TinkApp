class TinksController < ApplicationController
  def index
  end

  def new
  	@tink = Tink.new
    @tink.title = params[:title]
    @tink.url = params[:url]

  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tink }
    end
  end

  def create
  	@tink = Tink.new(params[:tink])

    bitly = Bitly.new('fleetcreations', 'R_77619b7f25394f4f4790e4455249832e')
    u = bitly.shorten(@tink.url)

    notification = {
      :device_tokens => ['5B3275894AEB9D7E9693EBD33105B54ECCA8CE4CB7EC11D846B47FCCC0607EEB'],
      :aps => {:alert => "#{@tink.title} #{u.short_url}", :badge => 1}
    }



  	respond_to do |format|
  		if @tink.save
        Urbanairship.push(notification)
  			
        format.html { redirect_to @tink, notice: "Tink was successfully created and sent."}
  			format.json { render json: @user, status: :created, location: @tink }
  		else
  			format.html { render action: "new"}
  			format.json { redner json: @tink.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def show
  	@tink = Tink.find(params[:id])

  	respond_to do |format|
  		format.html #show.html.erb
  		format.json { render json: @tink }
  	end
  end
end